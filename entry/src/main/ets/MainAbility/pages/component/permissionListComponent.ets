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
export default struct PermissionListComponent {
  private permissionName: string = '';
  private permissionDescription: string = '';

  build() {
    Row() {
      Column() {
        Text(this.permissionName)
          .fontColor($r('app.color.color_333333_grey'))
          .fontSize($r('app.float.font_20'))
          .textAlign(TextAlign.Start)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .visibility('' === this.permissionName || undefined === this.permissionName
            ? Visibility.None : Visibility.Visible)
          .margin({
            left: $r('app.float.wh_value_15'),
            top: $r('app.float.wh_value_5'),
            bottom: $r('app.float.wh_value_5')
          });

        Text(this.permissionDescription)
          .fontColor($r('app.color.color_999999_grey'))
          .fontSize($r('app.float.font_20'))
          .textAlign(TextAlign.Start)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .visibility('' === this.permissionDescription || undefined === this.permissionDescription
            ? Visibility.None : Visibility.Visible)
          .margin({
            left: $r('app.float.wh_value_15'),
            top: $r('app.float.wh_value_5'),
            bottom: $r('app.float.wh_value_5')
          });
      }
      .alignItems(HorizontalAlign.Start)
    }
    .align(Alignment.Start)
    .alignItems(VerticalAlign.Center)
  }
}