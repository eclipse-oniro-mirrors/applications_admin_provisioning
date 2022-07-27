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

import baseData from '../../common/baseData'
import logger from '../../common/logger'
import returnInfo from '../component/automanager/returninfo'

@Entry
@Component
struct UnitManagerShowPage {
  @StorageLink('manageUrl') manageUrl: string = AppStorage.Get('manageUrl');
  controller: WebController = new WebController();

  build() {
    Column() {
      GridContainer({
        columns: vp2px(1) === 2 ? 12 : 8,
        sizeType: SizeType.Auto,
        gutter: '12vp',
        margin: '12vp'
      }) {
        Column() {
          returnInfo({ headName: $r('app.string.manageInfo') })
        }
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
          Web({ src: this.manageUrl, controller: this.controller })
            .onErrorReceive((event?: {
              request: WebResourceRequest,
              error: WebResourceError
            }) => {
              logger.warn('UnitManagerShowPage', 'error code=' + event.error.getErrorCode() +
              ', error info=' + event.error.getErrorInfo() + ', request url=' + event.request.getRequestUrl())
            })
            .onHttpErrorReceive((event?: {
              request: WebResourceRequest,
              response: WebResourceResponse
            }) => {
              logger.warn('UnitManagerShowPage', 'response code=' + event.response.getResponseCode() +
              ', response message=' + event.response.getReasonMessage() +
              ', response data=' + event.response.getResponseData() + ', request url=' + event.request.getRequestUrl())
            })
            .onRenderExited((event?: {
              renderExitReason: RenderExitReason
            }) => {
              logger.warn('UnitManagerShowPage', 'renderExitReason=' + event.renderExitReason);
            })
            .useSizeType({
              xs: { span: 4, offset: 2 }, sm: { span: 4, offset: 2 },
              md: { span: 4, offset: 2 }, lg: { span: 4, offset: 2 }
            })
        }
        .useSizeType({
          xs: { span: 8, offset: 0 }, sm: { span: 8, offset: 0 },
          md: { span: 8, offset: 0 }, lg: { span: 8, offset: 2 }
        })
      }
    }
    .backgroundColor(0xF1F3F5)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    logger.info('UnitManagerShowPage', 'manageUrl=' + this.manageUrl)
    if (!this.manageUrl.startsWith(baseData.HTTPS)) {
      this.manageUrl = '';
    }
  }
}