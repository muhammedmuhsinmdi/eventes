class PagedResponse<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  PagedResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PagedResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return PagedResponse<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>).map((itemJson) => fromJson(json['results'])).toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJson) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((item) => toJson(item)).toList(),
    };
  }
}