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

class CheckValid {
    isValid(item: any): boolean {
        if (item === null || item === undefined) {
            return false;
        }
        return true;
    }

    checkObjPropertyValid(obj: any, tree: string) {
        if (!obj ||  obj === 'undefined' || obj === undefined) {
            return false;
        }

        let arr = tree.split('.');
        let tempObj = obj;
        for (let i = 0; i < arr.length; i++) {
            if(tempObj[arr[i]] === undefined || tempObj[arr[i]] === null) {
                return false;
            } else {
                tempObj = tempObj[arr[i]];
            }
        }
        return true;
    }

    isLargeDevice(): number {
        return vp2px(1) === 2 ? 12 : 8;
    }
}

export default new CheckValid();