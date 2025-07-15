import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;

  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isPrefixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color? fillColor;
  final bool isRequired;
  final double borderRadius;
  final bool noneBorder;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    this.labelText,
    this.readOnly = false,
    this.fillColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isPrefixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = true,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = true,
    this.isRequired = false,
    this.borderRadius = Dimensions.defaultRadius,
    this.noneBorder = false, this.style,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
              ? TextFormField(
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnly,
                  style:widget.style?? regularDefault.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
                  controller: widget.controller,
                  autofocus: false,
                  textInputAction: widget.inputAction,
                  enabled: widget.isEnable,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  keyboardType: widget.textInputType,
                  obscureText: widget.isPassword ? obscureText : false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space15,
                      vertical: Dimensions.space5,
                    ),
                    labelText: widget.labelText,
                    labelStyle: regularDefault.copyWith(
                      color: ColorResources.dark10,
                    ),
                    hintText: widget.hintText,
                    hintStyle: regularLarge.copyWith(
                      color: ColorResources.dark45,
                    ),
                    fillColor: widget.fillColor ?? ColorResources.whiteColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: widget.noneBorder
                          ? BorderSide.none
                          : BorderSide(width: 1, color: ColorResources.dark10),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: widget.noneBorder
                          ? BorderSide.none
                          : BorderSide(
                              width: 0.5,
                              color: ColorResources.dark10,
                            ),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: widget.noneBorder
                          ? BorderSide.none
                          : BorderSide(width: 1, color: ColorResources.dark10),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    prefixIcon: widget.isPrefixIcon
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              // horizontal: 2,
                              vertical: Dimensions.space8,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/ic_search.svg',
                            ),
                          )
                        : null,
                    suffixIcon: widget.isShowSuffixIcon
                        ? widget.isPassword
                              // ? IconButton(
                              //     icon: Icon(
                              //       obscureText
                              //           ? Icons.visibility_off
                              //           : Icons.visibility,
                              //       color: ColorResources.dark45,
                              //       size: 20,
                              //     ),
                              //     onPressed: _toggle,
                              //   )
                              // : widget.isIcon
                              ? GestureDetector(
                                  onTap: _toggle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      obscureText
                                          ? 'assets/images/eye_close.svg'
                                          : 'assets/images/eye.svg',
                                      color: ColorResources.dark75,
                                    ),
                                  ),
                                )
                              : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                        ? Icons.arrow_drop_down_outlined
                                        : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: ColorResources.getPrimaryColor(),
                                  ),
                                )
                              : null
                        : null,
                  ),
                  onFieldSubmitted: (text) => widget.nextFocus != null
                      ? FocusScope.of(context).requestFocus(widget.nextFocus)
                      : null,
                  onChanged: (text) => widget.onChanged!(text),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(
                      text: widget.labelText.toString(),
                      isRequired: widget.isRequired,
                    ),
                    const SizedBox(height: Dimensions.textToTextSpace),
                    TextFormField(
                      maxLines: widget.maxLines,
                      readOnly: widget.readOnly,
                      style:
                          widget.style ?? regularDefault.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      cursorColor: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.color,
                      controller: widget.controller,
                      autofocus: false,
                      textInputAction: widget.inputAction,
                      enabled: widget.isEnable,
                      focusNode: widget.focusNode,
                      validator: widget.validator,
                      keyboardType: widget.textInputType,
                      obscureText: widget.isPassword ? obscureText : false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space15,
                          vertical: Dimensions.space5,
                        ),
                        hintText: widget.hintText,
                        hintStyle: regularSmall.copyWith(
                          color: ColorResources.getdark45(),
                        ),
                        fillColor: widget.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: widget.noneBorder
                              ? BorderSide.none
                              : BorderSide(
                                  width: 1,
                                  color: ColorResources.getdark45(),
                                ),
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: widget.noneBorder
                              ? BorderSide.none
                              : BorderSide(
                                  width: 1,
                                  color: ColorResources.getdark45(),
                                ),
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: widget.noneBorder
                              ? BorderSide.none
                              : BorderSide(
                                  width: 1,
                                  color: ColorResources.getdark45(),
                                ),
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                        prefixIcon: widget.isPrefixIcon
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space8,
                                ),
                                child: SvgPicture.asset(
                                  'assets/image/search_btn.svg',
                                ),
                              )
                            : null,
                        suffixIcon: widget.isShowSuffixIcon
                            ? widget.isPassword
                                  ? GestureDetector(
                                      onTap: _toggle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          obscureText
                                              ? 'assets/images/eye_close.svg'
                                              : 'assets/images/eye.svg',
                                          color: ColorResources.dark75,
                                        ),
                                      ),
                                    )
                                  : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: ColorResources.getPrimaryColor(),
                                      ),
                                    )
                                  : null
                            : null,
                      ),
                      onFieldSubmitted: (text) => widget.nextFocus != null
                          ? FocusScope.of(
                              context,
                            ).requestFocus(widget.nextFocus)
                          : null,
                      onChanged: (text) => widget.onChanged!(text),
                    ),
                  ],
                )
        : TextFormField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style:
                widget.style ?? regularDefault.copyWith(color: ColorResources.getdark45()),
            //textAlign: TextAlign.left,
            cursorColor: ColorResources.getdark45(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5,
                horizontal: 0,
              ),
              labelText: widget.labelText?.tr,
              labelStyle: regularDefault.copyWith(
                color: ColorResources.getdark45(),
              ),
              fillColor: ColorResources.transparentColor,
              filled: true,
              border: UnderlineInputBorder(
                borderSide: widget.noneBorder
                    ? BorderSide.none
                    : BorderSide(width: 1, color: ColorResources.getdark45()),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: ColorResources.getdark45(),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: ColorResources.getdark45(),
                ),
              ),
              prefixIcon: widget.isPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space8,
                      ),
                      child: SvgPicture.asset('assets/image/search_btn.svg'),
                    )
                  : null,
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                        ? GestureDetector(
                            onTap: _toggle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                obscureText
                                    ? 'assets/images/eye_close.svg'
                                    : 'assets/images/eye.svg',
                                color: ColorResources.dark75,
                              ),
                            ),
                          )
                        : widget.isIcon
                        ? IconButton(
                            onPressed: widget.onSuffixTap,
                            icon: Icon(
                              widget.isSearch
                                  ? Icons.search_outlined
                                  : widget.isCountryPicker
                                  ? Icons.arrow_drop_down_outlined
                                  : Icons.camera_alt_outlined,
                              size: 25,
                              color: ColorResources.getPrimaryColor(),
                            ),
                          )
                        : null
                  : null,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : null,
            onChanged: (text) => widget.onChanged!(text),
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}

class LabelText extends StatelessWidget {
  final bool isRequired;
  final String text;
  final TextAlign? textAlign;

  const LabelText({
    super.key,
    required this.text,
    this.textAlign,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return isRequired
        ? Row(
            children: [
              Text(
                text.tr,
                textAlign: textAlign,
                style: regularDefault.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                '*',
                style: semiBoldDefault.copyWith(
                  color: ColorResources.primaryColor,
                ),
              ),
            ],
          )
        : Text(
            text.tr,
            textAlign: textAlign,
            style: regularDefault.copyWith(
              color: ColorResources.dark10,
              fontSize: Dimensions.fontSmall,
            ),
          );
  }
}
