import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_kart_hafiza/oyun_kart_hafiza.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(kartHafizaConfig.title.length, 33);
    expect(kartHafizaConfig.tagline.length, 33);
    for (final s in kartHafizaConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler çözülebilir', () {
    final planner = LevelPlanner(gameId: kartHafizaId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = kartHafizaRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final game = MemoryGame(gl.puzzle);
      while (!game.won) {
        final h = game.hint()!;
        game.pick(h.$1);
        expect(game.pick(h.$2), isTrue);
      }
    }
  });
}
