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

import Ability from '@ohos.application.Ability'
import logger from '../common/logger'

export default class AutoManagerAbility extends Ability {
    onCreate(want, launchParam) {
        logger.info('AutoManagerAbility', 'onCreate')
        globalThis.autoManagerAbilityWant = want;
        globalThis.autoManagerAbilityContext = this.context;
    }

    onDestroy() {
        logger.info('AutoManagerAbility', 'onDestroy')
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        logger.info('AutoManagerAbility', 'onWindowStageCreate')
        windowStage.setUIContent(this.context, "pages/autoManager/managerStart", null)
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        logger.info('AutoManagerAbility', 'onWindowStageDestroy')
    }

    onForeground() {
        // Ability has brought to foreground
        logger.info('AutoManagerAbility', 'onForeground')
    }

    onBackground() {
        // Ability has back to background
        logger.info('AutoManagerAbility', 'onBackground')
    }
};
