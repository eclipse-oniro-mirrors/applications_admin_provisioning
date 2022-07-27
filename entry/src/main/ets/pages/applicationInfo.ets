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

import edmEnterpriseDeviceManager from '@ohos.enterpriseDeviceManager';
import router from '@ohos.router';
import appDetailData from '../common/appManagement/appDetailData'
import baseData from '../common/baseData';
import entryComponent from './component/entryComponent'
import headComponent from './component/headComponent';
import logger from '../common/logger'
import permissionListComponent from './component/permissionListComponent';

let appInfo;
let elementNameVal;
let isAdminTypeVal;
let isActiveState;
let enterInfo;

@Entry
@Component
struct ApplicationInfo {
  @StorageLink('applicationInfo') applicationInfo: any = {};
  @State isShowActive: boolean = false;
  @State isEnableButton: boolean = false;
  @StorageLink('activeType') isAdminType: number = 0;
  @State deviceAdminActive: string = '';
  @State deviceAdminDisActive: string = '';
  @State enterpriseName: string = '';
  @State enterpriseDescription: string = '';

  build() {
    Column() {
      Column() {
        GridContainer({
          columns: vp2px(1) === 2 ? 12 : 8,
          sizeType: SizeType.Auto,
          gutter: '12vp',
          margin: '12vp'
        }) {
          Column() {
            headComponent({ headName: $r('app.string.adminprovisioning') });

            Row() {
              entryComponent({
                appIcon: this.applicationInfo.appIcon,
                appTitle: this.applicationInfo.appTitle,
              })
            }

            Column() {
              Text(this.enterpriseName)
                .height($r('app.float.wh_value_21'))
                .fontColor($r('sys.color.ohos_id_color_text_primary'))
                .fontSize($r('app.float.font_16'))
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Start)
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({
                  left: $r('app.float.wh_value_36'),
                  top: $r('app.float.wh_value_12'),
                });

              Text(this.enterpriseDescription)
                .height($r('app.float.wh_value_19'))
                .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                .fontSize($r('app.float.font_14'))
                .fontWeight(FontWeight.Regular)
                .textAlign(TextAlign.Start)
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({
                  left: $r('app.float.wh_value_36'),
                  top: $r('app.float.wh_value_2'),
                });
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .align(Alignment.Start)

            Column() {
              Text(this.isShowActive ? this.deviceAdminActive : this.deviceAdminDisActive)
                .fontColor($r('sys.color.ohos_id_color_text_primary'))
                .fontSize($r('app.float.font_16'))
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Start)
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({
                  left: $r('app.float.wh_value_36'),
                  top: $r('app.float.wh_value_24'),
                });

              List() {
                ForEach(appInfo.appPermissionList, (item) => {
                  ListItem() {
                    permissionListComponent({
                      permissionName: item.permissionLabel,
                      permissionDescription: item.permissionDescription,
                    });
                  }
                }, item => JSON.stringify(item));
              }
            }
            .alignItems(HorizontalAlign.Start)
            .align(Alignment.Start)
          }
          .useSizeType({
            xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
            md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
          })
        }
      }
      .layoutWeight(1)

      Column() {
        GridContainer({
          columns: vp2px(1) === 2 ? 12 : 8,
          sizeType: SizeType.Auto,
          gutter: '12vp',
          margin: '12vp'
        }) {
          Row() {
            Row()
              .useSizeType({
                xs: { span: 1, offset: 0 }, sm: { span: 1, offset: 0 },
                md: { span: 1, offset: 0 }, lg: { span: 3, offset: 0 }
              })

            Button() {
              Text(this.isShowActive ? $r('app.string.deActivate') : $r('app.string.activation'))
                .opacity(this.isEnableButton ? 1 : 0.38)
                .fontSize($r('sys.float.ohos_id_text_size_button1'))
                .fontColor($r('sys.color.ohos_id_color_text_primary_activated'))
            }
            .enabled(this.isEnableButton)
            .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
            .height($r('app.float.button_height'))
            .margin({
              right: $r('app.float.wh_value_6'),
              bottom: $r('app.float.wh_value_24')
            })
            .onClick(() => {
              logger.info('ApplicationInfo', 'button active:' + this.isShowActive);
              this.activateAdmin(this.isAdminType);
            })
            .useSizeType({
              xs: { span: 3, offset: 1 }, sm: { span: 3, offset: 1 },
              md: { span: 3, offset: 1 }, lg: { span: 3, offset: 3 }
            })

            Button() {
              Text($r('app.string.cancel'))
                .fontSize($r('sys.float.ohos_id_text_size_button1'))
                .fontColor($r('sys.color.ohos_id_color_text_primary_activated'))
            }
            .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
            .height($r('app.float.button_height'))
            .margin({
              left: $r('app.float.wh_value_6'),
              bottom: $r('app.float.wh_value_24')
            })
            .onClick(() => {
              logger.info('ApplicationInfo', 'button cancel in isShowActive:' + this.isShowActive);
              appDetailData.terminateAbilityPage();
            })
            .useSizeType({
              xs: { span: 3, offset: 4 }, sm: { span: 3, offset: 4 },
              md: { span: 3, offset: 4 }, lg: { span: 3, offset: 6 }
            })

            Row()
              .useSizeType({
                xs: { span: 1, offset: 7 }, sm: { span: 1, offset: 7 },
                md: { span: 1, offset: 7 }, lg: { span: 3, offset: 9 }
              })
          }
          .justifyContent(FlexAlign.Center)
        }
      }.width('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  aboutToAppear(): void {
    appInfo = {
      appIcon: '',
      appTitle: '',
      appBundleName: '',
      appPermissionList: [],
    };

    elementNameVal = {
      abilityName: '',
      bundleName: '',
    };

    enterInfo = {
      name: '',
      description: '',
    };

    isAdminTypeVal = { admintype: 0 };
    logger.info('ApplicationInfo', 'aboutToAppear in');
    this.getCheckAbilityList(appInfo, elementNameVal, isAdminTypeVal);
    logger.info('ApplicationInfo', 'aboutToAppear out');
  }

  aboutToDisappear(): void {
    logger.info('ApplicationInfo', 'aboutToDisappear');
  }

  onPageShow(): void {
    logger.info('ApplicationInfo', 'onPageShow in');
    this.isAdminActive();
    logger.info('ApplicationInfo', 'onPageShow isActiveState =' + isActiveState);
    if (isActiveState === undefined || isActiveState === null) {
      return;
    }
    this.isShowActive = isActiveState;
    logger.info('ApplicationInfo', 'onPageShow out');
  }

  onPageHide() {
    logger.info('ApplicationInfo', 'onPageHide');
  }

  onBackPress() {
    logger.info('ApplicationInfo', 'onBackPress');
    router.back();
  }

  async isAdminActive() {
    let wantTemp = {
      bundleName: elementNameVal.bundleName,
      abilityName: elementNameVal.abilityName,
    };
    let retAppState;
    let retSuperState;
    logger.info('ApplicationInfo', 'isAdminActive elementNameVal.bundleName=' + elementNameVal.bundleName +
    ' | elementNameVal.abilityName=' + elementNameVal.abilityName);
    if (elementNameVal.bundleName === baseData.EMPTY_STR || elementNameVal.abilityName === baseData.EMPTY_STR) {
      logger.info('ApplicationInfo', 'isAdminActive elementNameVal is null');
      return;
    }

    retAppState = await edmEnterpriseDeviceManager.isAdminEnabled(wantTemp);
    retSuperState = await edmEnterpriseDeviceManager.isSuperAdmin(elementNameVal.bundleName);
    if (retAppState === false) {
      this.isShowActive = false;
      this.isEnableButton = true;
    } else {
      if (retSuperState === true) {
        this.isEnableButton = false;
      } else {
        this.isEnableButton = true;
      }
      this.isShowActive = true;
    }
    logger.info('ApplicationInfo', 'isAdminActive retAppState:' + retAppState +
    ' | retSuperState:' + retSuperState);
    isActiveState = this.isShowActive;
  }

  async activateAdmin(adminType) {
    logger.info('ApplicationInfo', 'activateAdmin isShowActive:' + this.isShowActive);
    let wantTemp = {
      bundleName: elementNameVal.bundleName,
      abilityName: elementNameVal.abilityName,
    };
    await this.isAdminActive();
    let ret;
    if (this.isShowActive === false) {
      if (adminType === edmEnterpriseDeviceManager.AdminType.ADMIN_TYPE_NORMAL) {
        ret = await edmEnterpriseDeviceManager.enableAdmin(wantTemp,
          { name: enterInfo.name, description: enterInfo.description },
          edmEnterpriseDeviceManager.AdminType.ADMIN_TYPE_NORMAL);
      } else {
        ret = await edmEnterpriseDeviceManager.enableAdmin(wantTemp,
          { name: enterInfo.name, description: enterInfo.description },
          edmEnterpriseDeviceManager.AdminType.ADMIN_TYPE_SUPER);
      }
      logger.info('ApplicationInfo', 'activateAdmin Activate admin end');
    } else {
      if (this.isEnableButton === true) {
        ret = await edmEnterpriseDeviceManager.disableAdmin(wantTemp);
      } else {
        logger.info('ApplicationInfo', 'activateAdmin not support super admin active');
      }
    }
    logger.info('ApplicationInfo', 'activateAdmin adminType:' + adminType + ' | ret:' + ret);
    appDetailData.terminateAbilityPage();
  }

  async getSelfResourceVal(resource) {
    let resMgr = await globalThis.adminProvisioningContext.resourceManager;
    logger.info('ApplicationInfo', 'getSelfResourceVal in:');
    let value = await resMgr.getString(resource.id);
    logger.info('ApplicationInfo', 'getSelfResourceVal finish value:' + value);
    if (value === undefined || value === null || value === baseData.EMPTY_STR) {
      return baseData.EMPTY_STR;
    }
    return value;
  }

  async getAbilityWantVal(appInfo, elementNameVal, adminType) {
    logger.info('ApplicationInfo', 'getAbilityWantVal in:');
    let data = await globalThis.adminProvisioningWant;
    let lengthVal = Object.keys(data.parameters).length;
    let includeElementNameVal = Object.keys(data.parameters).indexOf('elementName');
    let includeActiveTypeVal = Object.keys(data.parameters).indexOf('activeType');
    let includeEnterpriseVal = Object.keys(data.parameters).indexOf('enterprise');
    if (lengthVal === 0 || includeElementNameVal === -1 || includeActiveTypeVal === -1 ||
    includeEnterpriseVal === -1) {
      logger.info('ApplicationInfo', 'data.parameters = ' + JSON.stringify(data.parameters));
      return;
    }
    elementNameVal.abilityName = data.parameters.elementName.abilityName;
    elementNameVal.bundleName = data.parameters.elementName.bundleName;

    appInfo.appBundleName = data.parameters.elementName.bundleName;
    adminType.admintype = data.parameters.activeType;
    AppStorage.SetOrCreate('activeType', adminType.admintype);

    if (data.parameters.enterprise.name !== null && data.parameters.enterprise.name !== undefined) {
      enterInfo.name = data.parameters.enterprise.name.substring(0, baseData.MAX_LEN);
    }

    if (data.parameters.enterprise.description !== null &&
    data.parameters.enterprise.description !== undefined) {
      enterInfo.description = data.parameters.enterprise.description.substring(0, baseData.MAX_LEN);
    }

    logger.info('ApplicationInfo', 'getAbilityWantVal out isAdminTypeVal.admintype:' +
    isAdminTypeVal.admintype + ' enter.name=' + enterInfo.name + ' enter.des=' + enterInfo.description);
  }

  async getCheckAbilityList(appInfo, elementNameVal, adminType) {
    let deviceActiveOne = '';
    let deviceActiveTwo = '';
    let deviceDeactivate = '';
    let enterName = '';
    let enterDescription = '';
    let getName = '';
    let getDescription = '';
    logger.info('ApplicationInfo', 'getCheckAbilityList in:');
    await this.getAbilityWantVal(appInfo, elementNameVal, adminType);

    let ret = await appDetailData.checkAppItem(elementNameVal);
    if (!ret.val) {
      logger.info('ApplicationInfo', 'aboutToAppear not exist bundleName:' + appInfo.appBundleName);
      appDetailData.terminateAbilityPage();
      return;
    }

    await this.isAdminActive();

    if (appInfo.appBundleName) {
      await appDetailData.getBundleInfoItem(appInfo.appBundleName, appInfo);
    }

    deviceActiveOne = await this.getSelfResourceVal($r('app.string.device_active_1'));
    deviceActiveTwo = await this.getSelfResourceVal($r('app.string.device_active_2'));
    deviceDeactivate = await this.getSelfResourceVal($r('app.string.device_deactivate'));
    enterName = await this.getSelfResourceVal($r('app.string.enterprise_name'));
    enterDescription = await this.getSelfResourceVal($r('app.string.enterprise_description'));
    this.deviceAdminActive = deviceActiveOne + `${appInfo.appTitle}` + deviceActiveTwo;
    this.deviceAdminDisActive = deviceDeactivate + `${appInfo.appTitle}` + deviceActiveTwo;

    let want = {
      bundleName: elementNameVal.bundleName,
      abilityName: elementNameVal.abilityName,
    };
    let getEnterInfo = {
      name: '',
      description: '',
    };
    if (this.isShowActive) {
      logger.info('ApplicationInfo', 'getCheckAbilityList get getEnterInfo');
      getEnterInfo = await edmEnterpriseDeviceManager.getEnterpriseInfo(want);
    }

    logger.info('ApplicationInfo', 'getCheckAbilityList start enterpriseName=' + getEnterInfo.name
    + ' enterpriseDescription=' + getEnterInfo.description);
    if (getEnterInfo.name !== null && getEnterInfo.name !== undefined) {
      getName = getEnterInfo.name.substring(0, baseData.MAX_LEN);
    }
    if (getEnterInfo.description !== null && getEnterInfo.description !== undefined) {
      getDescription = getEnterInfo.description.substring(0, baseData.MAX_LEN);
    }

    if (this.isShowActive) {
      this.enterpriseName = enterName + getName;
      this.enterpriseDescription = enterDescription + getDescription;
    } else {
      this.enterpriseName = enterName + enterInfo.name;
      this.enterpriseDescription = enterDescription + enterInfo.description;
    }
    logger.info('ApplicationInfo', 'getCheckAbilityList enterpriseName=' + this.enterpriseName
    + ' enterpriseDescription=' + this.enterpriseDescription);
  }
}