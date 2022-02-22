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

import router from '@system.router';

@Entry
@Component
export default struct HeadComponent {
  private headName: string = '';

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.wh_value_50'))
        .height($r('app.float.wh_value_50'))
        .borderRadius($r('app.float.wh_value_15'))
        .margin({
          left: $r('app.float.wh_value_15'),
          top: $r('app.float.wh_value_5'),
          bottom: $r('app.float.wh_value_5')
        })
        .backgroundColor($r('app.color.color_00000000_transparent'))
        .visibility(Visibility.Visible)
        .onTouch(() => {
          router.back();
        })
      Text(this.headName)
        .fontSize($r('app.float.font_24'))
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('90%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ left: $r('app.float.wh_value_15'), right: $r('app.float.wh_value_15') })
    }
    .width('100%')
    .height($r('app.float.wh_value_70'))
    .alignItems(VerticalAlign.Center)
    .align(Alignment.Start)
  }
}