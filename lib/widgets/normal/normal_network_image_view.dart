import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:x_bank/utils/view_util.dart';

import '../material_inkwell_view.dart';

enum NetworkImagePathType { Network, File, Asset }

class NormalNetworkImageView extends StatelessWidget {
  final String url;
  final NetworkImagePathType? networkImagePathType;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final PlaceholderWidgetBuilder? placeholderWidgetBuilder;
  final LoadingErrorWidgetBuilder? loadingErrorWidgetBuilder;
  final double? radius;
  final bool useMaterial;
  final BoxFit fit;
  final VoidCallback? onClick;

  NormalNetworkImageView({
    Key? key,
    required this.url,
    this.networkImagePathType,
    this.width,
    this.height,
    this.margin,
    this.placeholderWidgetBuilder,
    this.loadingErrorWidgetBuilder,
    this.radius,
    this.useMaterial = true,
    this.fit = BoxFit.fill,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double theWidth = width ?? double.infinity;
    double theHeight = height ?? double.infinity;
    NetworkImagePathType theNetworkImagePathType =
        networkImagePathType ?? NetworkImagePathType.Network;
    Widget imageView = Container();
    if (url != "") {
      switch (theNetworkImagePathType) {
        case NetworkImagePathType.Network:
          imageView = CachedNetworkImage(
            placeholder: placeholderWidgetBuilder ??
                ViewUtil.getDefaultPlaceholder(context,
                    width: theWidth, height: theHeight),
            errorWidget: loadingErrorWidgetBuilder ??
                ViewUtil.getDefaultLoadingErrorWidgetBuilder(context,
                    width: theWidth, height: theHeight),
            imageUrl: url,
            width: theWidth,
            height: theHeight,
            fit: fit,
          );
          break;
        case NetworkImagePathType.File:
          imageView = Image.file(
            File(url),
            width: theWidth,
            height: theHeight,
            fit: fit,
          );
          break;
        case NetworkImagePathType.Asset:
          imageView = Image.asset(
            url,
            width: theWidth,
            height: theHeight,
            fit: fit,
          );
          break;
        default:
          imageView = Container();
          break;
      }
    }
    Widget sizeImageView = Container(
      margin: margin,
      width: theWidth,
      height: theHeight,
      child: imageView,
    );
    Widget contentView = useMaterial
        ? MaterialInkwellView(onClick: onClick, child: sizeImageView)
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onClick,
            child: sizeImageView,
          );
    return radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius!),
            clipBehavior: Clip.antiAlias,
            child: contentView,
          )
        : contentView;
  }
}
