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

import router from '@ohos.router';
import doubleButtonComponent from '../component/automanager/doublebuttoncomponent'
import logger from '../../common/logger'

@Entry
@Component
export default
struct ManagerStart {
  @State textContext: string | Resource = $r('app.string.unitManageDevice');
  @State textManager: string | Resource = $r('app.string.unitManage');
  @State textManagerBefore: string | Resource = $r('app.string.textManagerBefore');
  @State textManagerAfter: string | Resource = $r('app.string.textManagerAfter');
  @State textTerms: string | Resource = $r('app.string.textTerms');
  @State textTermsBefore: string | Resource = $r('app.string.textTermsBefore');

  build() {
    Column() {
      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          Image($r('app.media.ic_start'))
            .width($r('app.float.wh_value_40'))
            .height($r('app.float.wh_value_40'))
            .margin({ top: '72vp', bottom: '16vp' })
            .objectFit(ImageFit.Contain)

          Text(this.textContext)
            .height('40vp')
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Medium)
            .lineHeight($r('app.float.lineHeight_vp_41'))
            .fontSize($r('app.float.font_vp_30'))
            .fontFamily('HarmonyHeiTi')
        }
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
        })
        .width('100%')
        .align(Alignment.Center)

        Column() {
          Row() {
            Text() {
              Span(this.textTermsBefore)
                .fontWeight(FontWeight.Regular)
                .fontSize($r('app.float.font_vp_16'))
                .fontFamily('HarmonyHeiTi')

              Span(this.textTerms)
                .decoration({ type: TextDecorationType.None })
                .fontColor(0x007DFF)
                .fontSize($r('app.float.font_vp_16'))
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Regular)
                .onClick(() => {
                  router.push({ url: 'pages/autoManager/termsShowPage' })
                })

              Span(this.textManagerBefore)
                .fontWeight(FontWeight.Regular)
                .fontSize($r('app.float.font_vp_16'))
                .fontFamily('HarmonyHeiTi')

              Span(this.textManager)
                .decoration({ type: TextDecorationType.None })
                .fontColor(0x007DFF)
                .fontSize($r('app.float.font_vp_16'))
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Regular)
                .onClick(() => {
                  router.push({ url: 'pages/autoManager/unitManagerShowPage' })
                })

              Span(this.textManagerAfter)
                .fontWeight(FontWeight.Regular)
                .fontSize($r('app.float.font_vp_16'))
                .fontFamily('HarmonyHeiTi')
            }
            .lineHeight($r('app.float.lineHeight_vp_21_5'))
          }
          .useSizeType({
            xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
            md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
          })
          .width('100%')
          .margin({ top: '48vp' })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
      }

      Blank()

      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          Button() {
            Text($r('app.string.buttonAcceptAndContinue'))
              .fontSize($r('app.float.font_vp_16'))
              .fontFamily('HarmonyHeiTi')
              .fontWeight(FontWeight.Medium)
              .fontColor(0xFFFFFF)
              .lineHeight($r('app.float.lineHeight_vp_22'))
          }
          .backgroundColor(0x007DFF)
          .onClick(() => {
            router.push({ url: 'pages/autoManager/loadingInfo' })
          })
          .width('100%')
          .height('40vp')
          .useSizeType({
            xs: { span: 2, offset: 3 }, sm: { span: 2, offset: 3 },
            md: { span: 2, offset: 3 }, lg: { span: 2, offset: 3 }
          })
        }
        .width('100%')
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
        })
        .margin({ bottom: '100vp' })
      }

      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          doubleButtonComponent({ nextFlag: true, returnDialogFlag: false })
        }
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 12, offset: 0 }
        })
        .width('100%')
        .margin({ bottom: '16vp' })
      }
    }
    .backgroundColor(0xF1F3F5)
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    this.parseManageParameter();
  }

  parseManageParameter() {
    let data = globalThis.autoManagerAbilityWant;
    let lengthVal = Object.keys(data.parameters).length;
    let includeElementNameVal = Object.keys(data.parameters).indexOf('elementName');
    let includeUrlVal = Object.keys(data.parameters).indexOf('url');
    let includeTermsNameVal = Object.keys(data.parameters).indexOf('termsName');
    let includeTermsContentVal = Object.keys(data.parameters).indexOf('termsContent');
    let includeEnterpriseVal = Object.keys(data.parameters).indexOf('enterprise');

    if (lengthVal === 0 || includeElementNameVal === -1 || includeUrlVal === -1 || includeTermsNameVal === -1 ||
    includeTermsContentVal === -1 || includeEnterpriseVal === -1) {
      logger.error('ManagerStart', 'parseManageParameter fail! parameters=' + JSON.stringify(data.parameters))
      return;
    }

    if (this.isValid(data.parameters.elementName.abilityName)) {
      AppStorage.SetOrCreate('manageAbilityName', data.parameters.elementName.abilityName);
    }

    if (this.isValid(data.parameters.elementName.bundleName)) {
      AppStorage.SetOrCreate('manageBundleName', data.parameters.elementName.bundleName);
    }

    if (this.isValid(data.parameters.url)) {
      AppStorage.SetOrCreate('manageUrl', data.parameters.url);
    }

    if (this.isValid(data.parameters.termsName)) {
      AppStorage.SetOrCreate('manageTermsName', data.parameters.termsName);
    }

    if (this.isValid(data.parameters.termsContent) && Array.isArray(data.parameters.termsContent)) {
      AppStorage.SetOrCreate('manageTermsContent', data.parameters.termsContent);
    }

    if (this.isValid(data.parameters.enterprise.name)) {
      AppStorage.SetOrCreate('manageEnterpriseName', data.parameters.enterprise.name);
    }

    if (this.isValid(data.parameters.enterprise.description)) {
      AppStorage.SetOrCreate('manageEnterpriseDescription', data.parameters.enterprise.description);
    }
  }

  isValid(item) : boolean {
    if (item !== null && item !== undefined) {
      return true;
    }
    return false;
  }
}