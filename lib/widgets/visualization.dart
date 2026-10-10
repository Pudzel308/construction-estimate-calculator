import 'dart:math' as math;
import 'package:flutter/material.dart';

class IsometricBox extends StatelessWidget {
    final double length;
    final double width;
    final double thickness;

    const IsometricBox({
        super.key,
        required this.length,
        required this.width,
        required this.thickness,
    });

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: 400,
            height: 300,
            child: CustomPaint(
                painter: IsometricBoxPainter(
                    length: length,
                    width: width,
                    thickness: thickness,
                ),
            ),
        );
    }
}

class IsometricBoxPainter extends CustomPainter {
    final double length;
    final double width;
    final double thickness;

    IsometricBoxPainter({
        required this.length,
        required this.width,
        required this.thickness,
    });

    @override
    void paint(Canvas canvas, Size size) {
        // Prevent negative/invalid values.
        final l = math.max(length, 0).toDouble();
        final w = math.max(width, 0).toDouble();
        final t = math.max(thickness, 0).toDouble();

        if (l == 0 || w == 0 || t == 0) {
      return;
    }

        // ------------------------------------------------------------
        // SCALE
        // ------------------------------------------------------------
        //
        // All dimensions use the SAME scale.
        //
        // This preserves:
        //
        // L : W : T
        //
        // For example:
        // 1.5 : 1.5 : 0.25
        //
        final maxDimension = math.max(
            math.max(l, w),
            t,
        );

        final scale = 150 / maxDimension;

        final L = l * scale;
        final W = w * scale;
        final T = t * scale;

        // ------------------------------------------------------------
        // ISOMETRIC DIRECTIONS
        // ------------------------------------------------------------

        // Length goes horizontally to the right.
        final lengthVector = Offset(L, 0);

        // Width goes diagonally up-right.
        final widthVector = Offset(
            W * 0.65,
            -W * 0.45,
        );

        // Thickness goes vertically downward.
        final thicknessVector = Offset(0, T);

        // ------------------------------------------------------------
        // CENTER THE OBJECT
        // ------------------------------------------------------------

        final totalWidth = lengthVector.dx + widthVector.dx;

        final totalHeight =
        widthVector.dy.abs() + thicknessVector.dy;

        final origin = Offset(
        (size.width - totalWidth) / 2,
        (size.height - totalHeight) / 2 + widthVector.dy.abs(),
        );

        // ------------------------------------------------------------
        // VERTICES
        // ------------------------------------------------------------

        final p0 = origin;

        final p1 = p0 + lengthVector;
        final p2 = p1 + widthVector;
        final p3 = p0 + widthVector;

        final p4 = p0 + thicknessVector;
        final p5 = p1 + thicknessVector;
        final p6 = p2 + thicknessVector;
        final p7 = p3 + thicknessVector;

        // ------------------------------------------------------------
        // PAINTS
        // ------------------------------------------------------------

        final topPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

        final frontPaint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;

        final sidePaint = Paint()
        ..color = Colors.blueGrey
        ..style = PaintingStyle.fill;

        final outlinePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

        // ------------------------------------------------------------
        // TOP
        // ------------------------------------------------------------

        final top = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy)
        ..close();

        canvas.drawPath(top, topPaint);
        canvas.drawPath(top, outlinePaint);

        // ------------------------------------------------------------
        // FRONT
        // ------------------------------------------------------------

        final front = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p5.dx, p5.dy)
        ..lineTo(p4.dx, p4.dy)
        ..close();

        canvas.drawPath(front, frontPaint);
        canvas.drawPath(front, outlinePaint);

        // ------------------------------------------------------------
        // RIGHT SIDE
        // ------------------------------------------------------------

        final side = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p6.dx, p6.dy)
        ..lineTo(p5.dx, p5.dy)
        ..close();

        canvas.drawPath(side, sidePaint);
        canvas.drawPath(side, outlinePaint);

        // ------------------------------------------------------------
        // DIMENSIONS
        // ------------------------------------------------------------

        _drawLengthDimension(
            canvas,
            p5,
            p6,
            offset: 25,
            label: '${_formatNumber(w)} m (L)',
        );

        _drawWidthDimension(
            canvas,
            p3,
            p2,
            offset: 15,
            label: '${_formatNumber(l)} m (W)',
        );

        _drawThicknessDimension(
            canvas,
            p0,
            p4,
            offset: -15,
            label: '${_formatNumber(t)} m (T)',
        );
    }

    // ============================================================
    // LENGTH DIMENSION
    // ============================================================

    void _drawLengthDimension(
        Canvas canvas,
        Offset start,
        Offset end, {
        required double offset,
        required String label,
    }) {
        final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 1;

        final dimensionStart = start + Offset(offset, 0);
        final dimensionEnd = end + Offset(offset, 0);

        // Extension lines.
        canvas.drawLine(start, dimensionStart, paint);
        canvas.drawLine(end, dimensionEnd, paint);

        // Dimension line.
        canvas.drawLine(
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionEnd,
            dimensionStart,
            paint,
        );
        
        final midpoint = Offset(
        (dimensionStart.dx + dimensionEnd.dx) / 2,
        (dimensionStart.dy + dimensionEnd.dy) / 2,
        );

        _drawLabel(
            canvas,
            label,
            midpoint + Offset(30, 0),
        );
    }

    // ============================================================
    // WIDTH DIMENSION
    // ============================================================

    void _drawWidthDimension(
        Canvas canvas,
        Offset start,
        Offset end, {
        required double offset,
        required String label,
    }) {
        final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 1;

        // Perpendicular offset for the diagonal dimension.
        final direction = end - start;

        final length = direction.distance;

        if (length == 0) return;

        final normal = Offset(
            direction.dy / length,
            -direction.dx / length,
        );

        final dimensionStart = start + normal * offset;
        final dimensionEnd = end + normal * offset;

        // Extension lines.
        canvas.drawLine(start, dimensionStart, paint);
        canvas.drawLine(end, dimensionEnd, paint);

        // Dimension line.
        canvas.drawLine(
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionEnd,
            dimensionStart,
            paint,
        );

        final midpoint = Offset(
        (dimensionStart.dx + dimensionEnd.dx) / 2,
        (dimensionStart.dy + dimensionEnd.dy) / 2,
        );

        _drawLabel(
            canvas,
            label,
            midpoint + Offset(0, -8),
        );
    }

    // ============================================================
    // THICKNESS DIMENSION
    // ============================================================

    void _drawThicknessDimension(
        Canvas canvas,
        Offset start,
        Offset end, {
        required double offset,
        required String label,
    }) {
        final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 1;

        final dimensionStart = start + Offset(offset, 0);
        final dimensionEnd = end + Offset(offset, 0);

        // Extension lines.
        canvas.drawLine(start, dimensionStart, paint);
        canvas.drawLine(end, dimensionEnd, paint);

        // Dimension line.
        canvas.drawLine(
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionStart,
            dimensionEnd,
            paint,
        );

        _drawArrow(
            canvas,
            dimensionEnd,
            dimensionStart,
            paint,
        );

        final midpoint = Offset(
        (dimensionStart.dx + dimensionEnd.dx) / 2,
        (dimensionStart.dy + dimensionEnd.dy) / 2,
        );

        _drawLabel(
            canvas,
            label,
            midpoint + Offset(-25, 0),
        );
    }

    // ============================================================
    // ARROW
    // ============================================================

    void _drawArrow(
        Canvas canvas,
        Offset tip,
        Offset directionPoint,
        Paint paint,
    ) {
        final direction = directionPoint - tip;

        if (direction.distance == 0) return;

        final normalized = direction / direction.distance;

        final perpendicular = Offset(
            -normalized.dy,
            normalized.dx,
        );

        const arrowSize = 5.0;

        final p1 = tip + normalized * arrowSize;
        final p2 = tip +
        normalized * arrowSize * 0.5 +
        perpendicular * arrowSize * 0.5;

        final p3 = tip +
        normalized * arrowSize * 0.5 -
        perpendicular * arrowSize * 0.5;

        final path = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy)
        ..close();

        canvas.drawPath(
            path,
            paint..style = PaintingStyle.fill,
        );

        canvas.drawLine(tip, p1, paint);
    }

    // ============================================================
    // LABEL
    // ============================================================

    void _drawLabel(
        Canvas canvas,
        String text,
        Offset position,
    ) {
        final textPainter = TextPainter(
            text: TextSpan(
                text: text,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.bold
                ),
            ),
            textDirection: TextDirection.ltr,
        );

        textPainter.layout();

        textPainter.paint(
            canvas,
            position - Offset(
                textPainter.width / 2,
                textPainter.height / 2,
            ),
        );
    }

    String _formatNumber(double value) {
        if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

        return value
            .toStringAsFixed(2)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
    }

    @override
    bool shouldRepaint(covariant IsometricBoxPainter oldDelegate) {
        return oldDelegate.length != length ||
            oldDelegate.width != width ||
            oldDelegate.thickness != thickness;
    }
}
