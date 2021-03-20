

import 'GeneticPair.dart';
import 'Morph.dart';

void main() {
  Genetic.initialize();
  print(Genetic.fromName("アシッド"));
  Morph.Calc([new GeneticPair.auto(Genetic.fromName("アシッド")),new GeneticPair.auto(Genetic.fromName("アロイ"),info: Info.Super)],
      [new GeneticPair.auto(Genetic.fromName("アロイ")),new GeneticPair.auto(Genetic.fromName("アルファ"))]);
}

class Genetic {
  final String name;

  final Order order;

  final int ID;

  Genetic(this.name, this.ID, this.order);

  static void initialize() {
    var id = 1;
    dominance.forEach((element) {
      genetics.add(new Genetic(element, id, Order.Dominance));
      id++;
    });
    coDominances.forEach((element) {
      genetics.add(new Genetic(element, id, Order.CoDominance));
      id++;
    });
    recessives.forEach((element) {
      genetics.add(new Genetic(element, id, Order.Recessive));
      id++;
    });
  }
static final normal=new Genetic("ノーマル", 0, Order.Normal);
  static List<Genetic> genetics = [normal];

  static Genetic fromName(String name) {
    return genetics.firstWhere((element) => element.name == name);
  }

  static Genetic fromID(int id) {
    return genetics.firstWhere((element) => element.ID == id);
  }

  static List<String> dominance = [
    "アシッド",
    "アプリコット",
    "アラザ",
    "アリド",
    "ARP",
    "アヘン",
    "アスファルト",
    "ボールドジーン(ボールドゲン)",
    "ビアンカボール",
    "ビンゴ",
    "ブラックアダー",
    "ブラックベリー",
    "ブラックナイト",
    "ブリッツ",
    "ブライトボール",
    "ブルズアイ",
    "カファ",
    "キャリコ",
    "キャリコスーパーヒュージョン",
    "カンタループ",
    "シンダー",
    "シナモン",
    "シトラス",
    "コーヒー",
    "コンフュジオン",
    "コンゴ",
    "コスミック",
    "クリームボール",
    "キュービット",
    "ダブルストライプ(Ｄ-ストライプ)",
    "デイジー",
    "ダークワンダー",
    "ディーム",
    "デザートボール",
    "DNA",
    "エニグマ",
    "エピック",
    "フリーク",
    "フエーゴ",
    "ギャラクシー",
    "ガルシアチョコレート",
    "ジェネティックバラックバック",
    "ジンX",
    "ハーレィクイン",
    "ハイイエロー",
    "ハイブッシュ",
    "HPK",
    "アイスファイア",
    "ジャクソン",
    "ジョッパ",
    "ジョージーボール",
    "ジュマンジボール",
    "カラバッシュリダクションジン",
    "コスモス",
    "クトゥルフ",
    "ラディス",
    "レオパードボール",
    "ルシファー",
    "マジェスティック",
    "マーカー",
    "モコ",
    "マンダリン",
    "マンガボール",
    "マリオ",
    "ミルクチョコレート",
    "ナニーボール",
    "ナパーム",
    "ネブラ",
    "ネモ",
    "ノヴァ",
    "NRマンダリン",
    "OFY",
    "オレンジグロー",
    "レディオアクティビ",
    "レイブン",
    "レッドヘッド",
    "サファリ",
    "サファイア",
    "サンライズ",
    "シャッター",
    "シノビ",
    "シュラプネル",
    "シエナ",
    "シエラ",
    "ソーラーボール",
    "スパークル",
    "スパイダー",
    "スプラッシュ",
    "スタティック",
    "スティンガー",
    "ストレッチャーSNA",
    "テラ",
    "トキシック",
    "トリック",
    "ターボ",
    "ツイスター",
    "ベガ",
    "ウェブ",
    "ホワイトアウト",
    "ウィルバンクスグラナイト",
    "ウーキー"
  ];
  static List<String> coDominances = [
    "アロイ",
    "アルファ",
    "アークティック",
    "アローヨ(アロヨ)(het.リオ)",
    "バンブー",
    "バナナボール",
    "ブラックヘッド",
    "ブラックオパール",
    "ブラックパステル",
    "ブレイド",
    "ブリングイエローベリー",
    "ボンゴ",
    "ブラウンバック",
    "バター",
    "カリスト",
    "シャンパン",
    "チャコール",
    "チョコレート",
    "コーラルグロー",
    "コスモハベ",
    "クリード",
    "キプロス",
    "ダークリング",
    "ディスコ",
    "ドット",
    "エンバー",
    "エンチ",
    "Exo-LBB",
    "フェーダー",
    "ファイア",
    "フレイム",
    "フレア",
    "ジェネティックバンデット(タイガー)",
    "ジェネティックタイガー",
    "GHIボール",
    "グロッシー",
    "ゴブリン",
    "ゴールドブッシュモハベ",
    "グラベル(ヘテロハイウェイ)",
    "グリム",
    "グリムリーパー",
    "ハヤブサ",
    "ヘーゼル",
    "ダディー",
    "ヘテロサタン",
    "ヘテロレッドアザン",
    "ヒドゥンジンウォマ",
    "ハニー",
    "ハーフマン",
    "ハリケーン",
    "ハイドラ",
    "ジャバ",
    "ジェビ",
    "ジャングルウォマ",
    "レース(ブラックベルベット)",
    "レースブラックバック(グリーンパステル)",
    "LCブラックマジック",
    "レモンバック",
    "レッサー",
    "リリィ",
    "ローリィ",
    "ルミノソ",
    "マホガニー",
    "マシュー",
    "モカ",
    "モハベ",
    "モタ",
    "ミスティック",
    "ナスカ",
    "オレンジベリー",
    "オレンジドリーム",
    "オービット",
    "パイントボール",
    "パンサーティ",
    "パステル",
    "ファントム",
    "クエイク",
    "レッドストライプ",
    "リオ",
    "ルッソ",
    "セーブル",
    "ソース",
    "スケールレスヘッド",
    "シュレッダー",
    "スパーク(ヘテロプーマ)",
    "スペシャル",
    "スペクルド",
    "スペクター",
    "スプラッター",
    "スポットノーズ",
    "サルファ",
    "サンキスト",
    "トロンジャ",
    "THE401ボール",
    "サンダーボール",
    "トライデント",
    "バニラ",
    "ワールウィンド",
    "ウォマ",
    "エクストリームジン",
    "イエローベリー",
    "Z",
    "ジグ"
  ];
  static List<String> recessives = [
    "セブンダラーゴースト(7ドルゴースト)",
    "アルビノ(Ｔ-アルビノ)",
    "アルプス"
    "アトミック",
    "オータムグロス",
    "アザンティック",
    "バンデット",
    "ベンガル",
    "ブラックレース",
    "ブルゴーニュアルビノ",
    "ケイジャン",
    "キャンディ",
    "キャラメルアルビノ(Ｔ+アルビノ)",
    "シトラスハイポ",
    "クラウン",
    "デザートゴースト",
    "エンハンサー",
    "G1ハイポ",
    "ジェネティックストライプ",
    "ゴースト(ハイポ)",
    "ラベンダーアルビノ",
    "モナク",
    "オレンジクラッシュ",
    "パターンレス",
    "パイボールド",
    "パズルボール",
    "レインボー",
    "サハラ",
    "センチネル",
    "サンセットボール",
    "ザ・メイトリアーク",
    "トフィ",
    "トライストライプ(T-ストライプ)",
    "ウルトラメル"
  ];
  static List<String>? _morphs;

  static List<String> get morphs {
    //結合
    if (_morphs == null) {
      List<String> tmp = ["ノーマル"];
      tmp.addAll(recessives);
      tmp.addAll(dominance);
      tmp.addAll(coDominances);
      _morphs = tmp;
    }
    return _morphs!;
  }

  @override
  String toString() {
    //return '$name{order: ${Extension.enumToString(order)},id: $ID}';
    return ID!=0? name:"";
  }
}

/// # 遺伝性質を表すEnum型
enum Order {
  ///# 劣勢
  Recessive,

  ///# 優性
  Dominance,

  /// # 共優性
  CoDominance,

  // 例外
  Normal

  ///ノーマル
}
