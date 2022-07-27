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

import returnInfo from '../component/automanager/returninfo'
import termsListComponent from '../component/automanager/termslistcomponent'

@Entry
@Component
struct TermsShowPage {
  @State contentOfEnterpriseTerms: string[] = [];

  build() {
    Column() {
      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          returnInfo({ headName: $r('app.string.terms') })
        }
        .width('100%')
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 12, offset: 0 }
        })
      }

      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          termsListComponent({
            enterpriseCustomTerms: '企业自定义条款',
            contentOfEnterpriseTerms: this.contentOfEnterpriseTerms,
          })
        }
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
        })
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .backgroundColor(0xF1F3F5)
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.contentOfEnterpriseTerms.push(`${i}、您的单位管理员可以监控此设备的设置、应用、权限以及数据（其中包括您的网络活动以及您设备的位置信息、通话记录和联系人搜索记录）。`);
    }
    console.info(this.contentOfEnterpriseTerms.toLocaleString());
  }
}