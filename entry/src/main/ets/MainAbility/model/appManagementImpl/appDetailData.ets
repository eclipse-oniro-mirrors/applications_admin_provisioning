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

import abilityFeatureAbility from '@ohos.ability.featureAbility';
import bundle from '@ohos.bundle';
import resourceManager from '@ohos.resourceManager';
import baseData from '../baseData.ets';

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
    console.log('adminprovisioning checkAppItem in bundleName:' + elementNameVal.bundleName + ' | abilityName:' +
    elementNameVal.abilityName);
    let actionVal: string = 'ohos.action.ENT_ADMIN';
    let wantTemp = { "action": actionVal };
    let data = await bundle.queryAbilityByWant(wantTemp, bundle.BundleFlag.GET_BUNDLE_WITH_ABILITIES, baseData.USE_ID);
    for (let item in data) {
      console.log('adminprovisioning checkAppItem bundleName:' + data[item].bundleName + ' | name:' + data[item].name);
      if (data[item].bundleName === elementNameVal.bundleName && data[item].name === elementNameVal.abilityName) {
        this.ret.val = true;
        return this.ret;
      }
    }
    console.log('adminprovisioning checkAppItem return then false');
    this.ret.val = false;
    return this.ret;
  }

  async getBundleInfoItem(bundleName: string, appInfo) {
    console.log('adminprovisioning getBundleInfoItem in bundleName:' + bundleName);
    let data = await bundle.getBundleInfo(bundleName, bundle.BundleFlag.GET_BUNDLE_WITH_REQUESTED_PERMISSION);
    await this.getResourceItem(bundleName, data, appInfo);
    await this.getPermissionList(data, appInfo);
    console.log('adminprovisioning getBundleInfoItem out');
  }

  async getAppInfoLabel(resMgr, id) {
    let label = await resMgr.getString(id);
    console.log('adminprovisioning getAppInfoLabel start label:' + label);
    if (label === null || label === undefined || label === baseData.EMPTY_STR) {
      return baseData.EMPTY_STR;
    }
    return label;
  }

  async getAppInfoIcon(resMgr, id) {
    let iconVal = await resMgr.getMediaBase64(id);
    console.log('adminprovisioning getAppInfoIcon start iconVal:' + iconVal);
    if (iconVal === null || iconVal === undefined || iconVal === baseData.EMPTY_STR) {
      return baseData.EMPTY_STR;
    }
    return iconVal;
  }

  async getResourceItem(bundleName, data, appInfo) {
    console.log('adminprovisioning getResourceItem getResourceManager in');
    let resMgr = await resourceManager.getResourceManager(bundleName);
    let appInfoTemp = data.appInfo;
    let label = '';
    let iconVal = '';

    if (appInfoTemp.labelId > 0) {
      label = await this.getAppInfoLabel(resMgr, appInfoTemp.labelId);
      console.log('adminprovisioning getResourceItem success appInfo.label:' + label);
    } else {
      label = appInfoTemp.label;
      console.log('adminprovisioning getResourceItem defaults appInfo.label:' + label);
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
    console.log('adminprovisioning getResourceItem getResourceManager out');
  }

  async terminateAbilityPage() {
    console.log('adminprovisioning terminateAbilityPage in:');
    await abilityFeatureAbility.terminateSelf();
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
      console.log('adminprovisioning getPermissionList permission length:' + permissions.length);
      for (var i = 0; i < permissions.length; i++) {
        console.log('adminprovisioning getPermissionList permission is in val:' + permissions[i]);
        let j = this.getPermissionInfoVal(permissions[i]);
        if (j >= 0) {
          appInfo.appPermissionList.push({
            permissionName: permissionsDetailList[j].permissionName,
            permissionLabel: permissionsDetailList[j].permissionLabel,
            permissionDescription: permissionsDetailList[j].permissionDescription,
          });
        }
      }
      console.log('adminprovisioning getPermissionList permission appInfo.appPermissionList:' +
      JSON.stringify(appInfo.appPermissionList));
    }
    console.log('adminprovisioning getPermissionList permission out');
  }
}

let appDetailData = new AppDetailData();

export default appDetailData as AppDetailData;