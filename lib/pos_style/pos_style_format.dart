import '../pos_ticket_b68.dart';

class PosFormatText {
  final bool isUnderline;

  final int textSize;

  final double textScaleX;

  final double letterSpacing;

  final double lineSpacing;

  /// PosAlignment
  ///
  /// ALIGN_NORMAL = 0;
  /// ALIGN_OPPOSITE = 1;
  /// ALIGN_CENTER = 2;
  final int alignment;

  /// PosTextStyle
  ///
  /// NORMAL = 0;
  /// BOLD = 1;
  /// ITALIC = 2;
  /// BOLD_ITALIC = 3;
  final int textStyle;

  /// PosTextFont
  ///
  /// DEFAULT = 1;
  /// DEFAULT_BOLD = 2;
  /// MONOSPACE = 3;
  /// SANS_SERIF = 4;
  /// SERIF = 5;
  /// CUSTOM = 6;

  final int textFont;

  PosFormatText({
    this.isUnderline = false,
    this.textSize = 20,
    this.textScaleX = 1,
    this.letterSpacing = -0.05,
    this.lineSpacing = 0.5,
    this.alignment = PosAlignment.ALIGN_NORMAL,
    this.textStyle = PosTextStyle.NORMAL,
    this.textFont = PosTextFont.DEFAULT,
  });
}
