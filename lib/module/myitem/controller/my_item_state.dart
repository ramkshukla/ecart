import 'package:ecart/module/ecart_landing/model/ecart_landing_dto.dart';

class MyItemState {
  List<ECartLandingDTO> data;
  final bool isFetching;
  final bool isDeleting;
  MyItemState({
    required this.data,
    required this.isFetching,
    required this.isDeleting,
  });

  MyItemState copyWith({
    List<ECartLandingDTO>? data,
    bool? isFetching,
    bool? isDeleting,
  }) {
    return MyItemState(
      data: data ?? this.data,
      isFetching: isFetching ?? this.isFetching,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  String toString() {
    return "MyItemState(data: $data, isFetching: $isFetching, isDeleting: $isDeleting)";
  }
}
