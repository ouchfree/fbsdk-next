// Copyright (c) 2015-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "RCTConvert+FBSDKSharingContent.h"

@implementation RCTConvert(FBSDKSharingContent)

#pragma mark - Class Methods

+ (RCTFBSDKSharingContent)RCTFBSDKSharingContent:(id)json
{
  NSDictionary *contentData = [self NSDictionary:json];
  if (contentData) {
    id<FBSDKSharingContent> content = nil;
    // Build the right kind of content based on the specified content type
    NSString *contentType = [self NSString:contentData[@"contentType"]];
    if ([contentType isEqualToString:@"link"]) {
      content = RCTBuildLinkContent(contentData);
    } else if ([contentType isEqualToString:@"photo"]) {
      content = RCTBuildPhotoContent(contentData);
    } else if ([contentType isEqualToString:@"video"]) {
      content = RCTBuildVideoContent(contentData);
    } else {
      return nil;
    }
    if (content) {
      RCTAppendGenericContent(content, contentData[@"commonParameters"]);
    }
    return content;
  } else {
    return nil;
  }
}

#pragma mark - Helper Methods

static void RCTAppendGenericContent(RCTFBSDKSharingContent contentObject, NSDictionary *contentData)
{
  if (contentData) {
    contentObject.peopleIDs = [RCTConvert NSStringArray:contentData[@"peopleIds"]];
    contentObject.placeID = [RCTConvert NSString:contentData[@"placeId"]];
    contentObject.ref = [RCTConvert NSString:contentData[@"ref"]];
    contentObject.hashtag = [[FBSDKHashtag alloc] initWithString: [RCTConvert NSString:contentData[@"hashtag"]]];
  }
}

static FBSDKShareLinkContent *RCTBuildLinkContent(NSDictionary *contentData)
{
  FBSDKShareLinkContent *linkContent = [[FBSDKShareLinkContent alloc] init];
  linkContent.contentURL = [RCTConvert NSURL:contentData[@"contentUrl"]];
  linkContent.quote = [RCTConvert NSString:contentData[@"quote"]];
  return linkContent;
}

static FBSDKSharePhotoContent *RCTBuildPhotoContent(NSDictionary *contentData)
{
  NSArray *photoData = [RCTConvert NSArray:contentData[@"photos"]];
  FBSDKSharePhotoContent *photoContent = [[FBSDKSharePhotoContent alloc] init];
  NSMutableArray *photos = [[NSMutableArray alloc] init];
  // Generate an FBSDKSharePhoto for each item in photoData
  for (NSDictionary *p in photoData) {
    FBSDKSharePhoto *photo = RCTBuildPhoto(p);
    if (photo.image) {
      [photos addObject:photo];
    }
  }
  photoContent.photos = photos;
  photoContent.contentURL = [RCTConvert NSURL:contentData[@"contentUrl"]];
  return photoContent;
}

static FBSDKSharePhoto *RCTBuildPhoto(NSDictionary *photoData)
{
  UIImage *image = [RCTConvert UIImage:photoData[@"imageUrl"]];
  BOOL userGenerated = [RCTConvert BOOL:photoData[@"userGenerated"]];
  FBSDKSharePhoto *photo =[ [FBSDKSharePhoto alloc] initWithImage:image isUserGenerated:userGenerated];
  photo.caption = [RCTConvert NSString:photoData[@"caption"]];
  return photo;
}

static FBSDKShareVideoContent *RCTBuildVideoContent(NSDictionary *contentData)
{
  FBSDKShareVideoContent *videoContent = [[FBSDKShareVideoContent alloc] init];
  NSDictionary *videoData = [RCTConvert NSDictionary:contentData[@"video"]];
  NSURL *videoURL = [RCTConvert NSURL:videoData[@"localUrl"]];
  FBSDKShareVideo *video = [[FBSDKShareVideo alloc] initWithVideoURL:videoURL previewPhoto:nil];
  if (contentData[@"previewPhoto"]) {
    FBSDKSharePhoto *previewPhoto = RCTBuildPhoto([RCTConvert NSDictionary:contentData[@"previewPhoto"]]);
    video.previewPhoto = previewPhoto;
  }
  videoContent.video = video;
  videoContent.contentURL = [RCTConvert NSURL:contentData[@"contentUrl"]];
  return videoContent;
}

@end
