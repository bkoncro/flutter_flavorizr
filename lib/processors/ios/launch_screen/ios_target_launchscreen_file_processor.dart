/*
 * Copyright (c) 2022 MyLittleSuite
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

import 'package:flutter_flavorizr/parser/models/flavorizr.dart';
import 'package:flutter_flavorizr/processors/commons/copy_file_processor.dart';
import 'package:flutter_flavorizr/processors/commons/queue_processor.dart';
import 'package:flutter_flavorizr/processors/commons/replace_string_processor.dart';
import 'package:flutter_flavorizr/processors/commons/runtime_file_string_processor.dart';
import 'package:flutter_flavorizr/processors/commons/shell_processor.dart';
import 'package:flutter_flavorizr/utils/ios_utils.dart' as ios_utils;

class IOSTargetLaunchScreenFileProcessor extends QueueProcessor {
  IOSTargetLaunchScreenFileProcessor(
    String process,
    String script,
    String project,
    String source,
    String destination,
    String flavorName, {
    required Flavorizr config,
  }) : super(
          [
            CopyFileProcessor(
              source,
              '$destination/${flavorName}LaunchScreen.storyboard',
              config: config,
            ),
            RuntimeFileStringProcessor(
              '$destination/${flavorName}LaunchScreen.storyboard',
              ReplaceStringProcessor(
                '[[FLAVOR_NAME]]',
                flavorName,
                config: config,
              ),
              config: config,
            ),
            ShellProcessor(
              process,
              [
                script,
                project,
                ios_utils.flatPath(
                    '$destination/${flavorName}LaunchScreen.storyboard'),
              ],
              config: config,
            )
          ],
          config: config,
        );

  @override
  String toString() => 'IOSTargetLaunchScreenFileProcessor';
}
