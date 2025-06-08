import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/UI/koikoi/ruleUI.dart';
import 'package:hana_score/state/koikoiState.dart';
import 'package:hana_score/UI/koikoi/errorUI.dart';

class KoiKoi {
  static void condition(WidgetRef ref, BuildContext context, String rule) {
    Map<String, int> ruleList = ref.watch(ruleProvider);

    // 役の重複チェック
    if (ruleList.containsKey(rule)) {
      ErrorUI.errorDialog(context, rule, ref);
      return;
    }

    if (rule == '五光(10点)') {
      if (ruleList.containsKey('四光(8点)')) {
        final num = ruleList['四光(8点)']!;
        ruleList.remove('四光(8点)');
        ref.read(addScoreProvider.notifier).state -= num;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      if (ruleList.containsKey('三光(5点)')) {
        ruleList.remove('三光(5点)');
        ref.read(addScoreProvider.notifier).state -= 5;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      ref.read(addScoreProvider.notifier).state += 10;
      ruleList['五光(10点)'] = 10;
      ref.read(ruleProvider.notifier).state = ruleList;
    } else if (rule == '四光(8点)') {
      if (ruleList.containsKey('五光(10点)')) {
        ErrorUI.errorDialog(context, '五光(10点)', ref);
        return;
      }
      if (ruleList.containsKey('三光(5点)')) { 
        ruleList.remove('三光(5点)');
        ref.read(addScoreProvider.notifier).state -= 5;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      RuleUI.fourLight(ref, context);
    } else if (rule == '三光(5点)') {
      if (ruleList.containsKey('五光(10点)')) {
        ErrorUI.errorDialog(context, '五光(10点)', ref);
        return;
      } else if (ruleList.containsKey('四光(8点)')) {
        ErrorUI.errorDialog(context, '四光(8点)', ref);
        return;
      }
      RuleUI.threeLight(ref, context);
    } else if (rule == '花見で一杯\n(5点)') {
      atherFive(ref, rule);
    } else if (rule == '月見で一杯\n(5点)') {
      atherFive(ref, rule);
    } else if (rule == '猪鹿蝶(5点)') {
      if (ruleList.containsKey('タネ(1点)')) {
        int num = ruleList['タネ(1点)']!;
        ruleList.remove('タネ(1点)');
        ref.read(addScoreProvider.notifier).state -= num;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      RuleUI.atherFiveEx(ref, context, rule);
    } else if (rule == '赤短(5点)' || rule == '青短(5点)') {
      if (ruleList.containsKey('赤短・青短\n(10点)')) {
        ErrorUI.errorDialog(context, '赤短・青短\n(10点)', ref);
        return;
      }
      if (ruleList.containsKey('タン(1点)')) {
        int num = ruleList['タン(1点)']!;
        ruleList.remove('タン(1点)');
        ref.read(addScoreProvider.notifier).state -= num;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      RuleUI.atherFiveEx(ref, context, rule);
    } else if (rule == '赤短・青短\n(10点)') {
      if (ruleList.containsKey('赤短(5点)') || ruleList.containsKey('青短(5点)')) {
        int num = 0;
        if (ruleList.containsKey('赤短(5点)')) {
          num += ruleList['赤短(5点)']!;
          ruleList.remove('赤短(5点)');
        }
        if (ruleList.containsKey('青短(5点)')) {
          num += ruleList['青短(5点)']!;
          ruleList.remove('青短(5点)');
        }
        ref.read(addScoreProvider.notifier).state -= num;
        ref.read(ruleProvider.notifier).state = ruleList;
      }
      RuleUI.atherTenEx(ref, context, rule);
    } else if (rule == 'タネ(1点)') {
      if (ruleList.containsKey('猪鹿蝶(5点)')) {
        ErrorUI.errorDialog(context, '猪鹿蝶(5点)', ref);
        return;
      }
      RuleUI.atherOneEx(ref, context, rule);
    } else if (rule == 'タン(1点)') {
      if (ruleList.containsKey('赤短(5点)')) {
        ErrorUI.errorDialog(context, '赤短(5点)', ref);
        return;
      } else if (ruleList.containsKey('青短(5点)')) {
        ErrorUI.errorDialog(context, '青短(5点)', ref);
        return;
      } else if (ruleList.containsKey('赤短・青短\n(10点)')) {
        ErrorUI.errorDialog(context, '赤短・青短\n(10点)', ref);
        return;
      }
      RuleUI.atherOneEx(ref, context, rule);
    } else if (rule == 'カス(1点)') {
      RuleUI.atherOneEx(ref, context, rule);
    } else {
      debugPrint('条件が一致しません');
    }
  }

  static void atherFive(WidgetRef ref, String rule) {
    Map<String, int> ruleList = ref.watch(ruleProvider);
    ref.read(addScoreProvider.notifier).state += 5;
    ruleList[rule] = 5;
    ref.read(ruleProvider.notifier).state = ruleList;
  }
}
