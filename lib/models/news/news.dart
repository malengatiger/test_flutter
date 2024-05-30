import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final String? status;
  final int? totalResults;
  final List<Results>? results;
  final String? nextPage;

  const News({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });

  factory News.fromJson(Map<String, dynamic> json) =>
      _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'article_id')
  final String? articleId;
  final String? title;
  final String? link;
  final List<String>? keywords;
  final List<String>? creator;
  final String? description;
  final String? content;
  final String? pubDate;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'source_id')
  final String? sourceId;
  @JsonKey(name: 'source_priority')
  final int? sourcePriority;
  @JsonKey(name: 'source_url')
  final String? sourceUrl;
  @JsonKey(name: 'source_icon')
  final String? sourceIcon;
  final String? language;
  final List<String>? country;
  final List<String>? category;
  @JsonKey(name: 'ai_tag')
  final String? aiTag;
  final String? sentiment;
  @JsonKey(name: 'sentiment_stats')
  final String? sentimentStats;
  @JsonKey(name: 'ai_region')
  final String? aiRegion;
  @JsonKey(name: 'ai_org')
  final String? aiOrg;

  const Results({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
    this.aiTag,
    this.sentiment,
    this.sentimentStats,
    this.aiRegion,
    this.aiOrg,
  });

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
