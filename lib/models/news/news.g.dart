// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      status: json['status'] as String?,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPage: json['nextPage'] as String?,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'results': instance.results,
      'nextPage': instance.nextPage,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      articleId: json['article_id'] as String?,
      title: json['title'] as String?,
      link: json['link'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      creator:
          (json['creator'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      content: json['content'] as String?,
      pubDate: json['pubDate'] as String?,
      imageUrl: json['image_url'] as String?,
      sourceId: json['source_id'] as String?,
      sourcePriority: (json['source_priority'] as num?)?.toInt(),
      sourceUrl: json['source_url'] as String?,
      sourceIcon: json['source_icon'] as String?,
      language: json['language'] as String?,
      country:
          (json['country'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      aiTag: json['ai_tag'] as String?,
      sentiment: json['sentiment'] as String?,
      sentimentStats: json['sentiment_stats'] as String?,
      aiRegion: json['ai_region'] as String?,
      aiOrg: json['ai_org'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'article_id': instance.articleId,
      'title': instance.title,
      'link': instance.link,
      'keywords': instance.keywords,
      'creator': instance.creator,
      'description': instance.description,
      'content': instance.content,
      'pubDate': instance.pubDate,
      'image_url': instance.imageUrl,
      'source_id': instance.sourceId,
      'source_priority': instance.sourcePriority,
      'source_url': instance.sourceUrl,
      'source_icon': instance.sourceIcon,
      'language': instance.language,
      'country': instance.country,
      'category': instance.category,
      'ai_tag': instance.aiTag,
      'sentiment': instance.sentiment,
      'sentiment_stats': instance.sentimentStats,
      'ai_region': instance.aiRegion,
      'ai_org': instance.aiOrg,
    };
