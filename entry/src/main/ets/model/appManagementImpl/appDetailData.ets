/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bundle from '@ohos.bundle';
import accountManager from '../accountManager';
import baseData from '../baseData';

let icon_default = $r('app.media.icon');

const permissionsDetailList: Array<any> = [
  {
    "permissionName": 'ohos.permission.EDM_MANAGE_DATETIME',
    "permissionLabel": $r('app.string.permissionLabel'),
    "permissionDescription": $r('app.string.permissionDescription')
  },
];

export class AppDetailData {
  public ret = { val: false };

  async checkAppItem(elementNameVal) {
    console.info('adminprovisioning checkAppItem in bundleName:' + elementNameVal.bundleName + ' | abilityName:' +
    elementNameVal.abilityName);
    let wantTemp = {
        bundleName:elementNameVal.bundleName,
        abilityName:elementNameVal.abilityName
    };
    let userId = { localId : 0 };
    let retVal = await accountManager.getAccountUserId(userId);
    if (!retVal) {
      console.info('adminprovisioning checkAppItem getAccountUserId fail!');
      this.ret.val = false;
      return this.ret;
    }
    let data = await bundle.queryExtensionAbilityInfos(wantTemp, 11, 0, userId.localId);
    if (data === null || data === undefined || data.length <= 0) {
      console.info('adminprovisioning checkAppItem queryExtensionAbilityInfos fail! data is null');
      this.ret.val = false;
      return this.ret;
    }
    console.info('adminprovisioning checkAppItem return then false');
    this.ret.val = false;
    return this.ret;
  }

  async getBundleInfoItem(bundleName: string, appInfo) {
    console.info('adminprovisioning getBundleInfoItem in bundleName:' + bundleName);
    let userId = { localId : 0 };
    let retVal = await accountManager.getAccountUserId(userId);
    if (!retVal) {
      console.info('adminprovisioning getBundleInfoItem getAccountUserId fail!');
      return;
    }
    let data = await bundle.getBundleInfo(bundleName, bundle.BundleFlag.GET_BUNDLE_WITH_REQUESTED_PERMISSION,
      { "userId" : userId.localId });
    await this.getResourceItem(bundleName, data, appInfo);
    await this.getPermissionList(data, appInfo);
    console.info('adminprovisioning getBundleInfoItem out');
  }

  async getAppInfoLabel(resMgr, id) {
    let label = await resMgr.getString(id);
    console.info('adminprovisioning getAppInfoLabel start label:' + label);
    if (label === null || label === undefined || label === baseData.EMPTY_STR) {
      return baseData.EMPTY_STR;
    }
    return label;
  }

  async getAppInfoIcon(resMgr, id) {
    let iconVal = await resMgr.getMediaBase64(id);
    console.info('adminprovisioning getAppInfoIcon start iconVal:' + iconVal);
    if (iconVal === null || iconVal === undefined || iconVal === baseData.EMPTY_STR) {
      return baseData.EMPTY_STR;
    }
    return iconVal;
  }

  async getResourceItem(bundleName, data, appInfo) {
    console.info('adminprovisioning getResourceItem getResourceManager in');
    let bundleContext = await globalThis.adminProvisioningContext.createBundleContext(bundleName);
    let resMgr = await bundleContext.resourceManager;
    let appInfoTemp = data.appInfo;
    let label = '';
    let iconVal = '';

    if (appInfoTemp.labelId > 0) {
      label = await this.getAppInfoLabel(resMgr, appInfoTemp.labelId);
      console.info('adminprovisioning getResourceItem success appInfo.label:' + label);
    } else {
      label = appInfoTemp.label;
      console.info('adminprovisioning getResourceItem defaults appInfo.label:' + label);
    }

    if (appInfoTemp.iconId > 0) {
      iconVal = await this.getAppInfoIcon(resMgr, appInfoTemp.iconId);
      if (iconVal === baseData.EMPTY_STR) {
        appInfo.appIcon = icon_default;
        appInfo.appTitle = label;
      }
      appInfo.appIcon = iconVal;
      appInfo.appTitle = label;
      AppStorage.SetOrCreate('applicationInfo', appInfo);
    }
    console.info('adminprovisioning getResourceItem getResourceManager out');
  }

  async terminateAbilityPage() {
    console.info('adminprovisioning terminateAbilityPage in:');
    await globalThis.adminProvisioningContext.terminateSelf();
  }

  getPermissionInfoVal(permissionName): number {
    for (let i = 0; i < permissionsDetailList.length; i++) {
      if (permissionsDetailList[i].permissionName === permissionName) {
        return i;
      }
    }
    return -1;
  }

  async getPermissionList(data, appInfo) {
    let permissions = data.reqPermissions;
    if (permissions !== null && permissions !== []) {
      console.info('adminprovisioning getPermissionList permission length:' + permissions.length);
      for (var i = 0; i < permissions.length; i++) {
        console.info('adminprovisioning getPermissionList permission is in val:' + permissions[i]);
        let j = this.getPermissionInfoVal(permissions[i]);
        if (j >= 0) {
          appInfo.appPermissionList.push({
            permissionName: permissionsDetailList[j].permissionName,
            permissionLabel: permissionsDetailList[j].permissionLabel,
            permissionDescription: permissionsDetailList[j].permissionDescription,
          });
        }
      }
      console.info('adminprovisioning getPermissionList permission appInfo.appPermissionList:' +
      JSON.stringify(appInfo.appPermissionList));
    }
    console.info('adminprovisioning getPermissionList permission out');
  }
}

let appDetailData = new AppDetailData();

export default appDetailData as AppDetailData;