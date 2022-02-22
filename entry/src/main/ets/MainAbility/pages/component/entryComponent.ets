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

@Component
export default struct EntryComponent {
  @Prop appIcon: string;
  @Prop appTitle: string;

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Row() {
        Image(this.appIcon)
          .width($r('app.float.wh_value_50'))
          .height($r('app.float.wh_value_50'))
          .margin({ right: $r('app.float.wh_value_10') })
          .visibility('' === this.appIcon ? Visibility.None : Visibility.Visible)
          .objectFit(ImageFit.Contain);

        Text(this.appTitle)
          .fontColor($r('app.color.color_333333_grey'))
          .fontSize($r('app.float.font_20'))
          .textAlign(TextAlign.Start)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: $r('app.float.wh_value_10'), bottom: $r('app.float.wh_value_5') });
      }
      .flexShrink(0)
      .alignItems(VerticalAlign.Center)
      .align(Alignment.Start)
    }
    .margin({ left: $r('app.float.wh_value_15') })
    .width('100%')
  }
}