//
//  XJCoreDataManager.h
//  XJKitDemo
//
//  Created by 汤小军 on 2018/6/1.
//  Copyright © 2018年 汤小军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface XJCoreDataManager : NSObject

+ (instancetype)shareManager;

/**
 创建数据库

 @param DBName 数据库名字
 @return XJCoreDataManager
 */
- (instancetype)createCoreDataWithDB:(NSString *)DBName;


/**
 插入数据

 @param modelClass modelClass
 @param CoreDataModel CoreDataModel
 @param resultError 错误结果
 */
+ (void)inserDataWithCoreDataModelClass:(Class)modelClass CoreDataModel:(void(^)(id))CoreDataModel Error:(void(^)(NSError *error))resultError;


/**
 查询数据

 @param modelClass modelClass
 @param whereStr 查询条件 为nil 则查询全部
 @param arrResult 结果
 @param resultError 错误结果
 */
+ (void)fetchDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString*)whereStr  arrResult:(void(^)(NSArray *resultArr))arrResult Error:(void(^)(NSError *error))resultError;


/**
 删除数据

 @param modelClass modelClass
 @param whereStr 删除条件 为nil 则查询全部
 @param deleteResult deleteSuccess
 @param resultError 错误结果
 */
+ (void)deleteDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString*)whereStr  deleteResult:(void(^)(BOOL))deleteResult Error:(void(^)(NSError *error))resultError;

/**
 更新数据
 
 @param modelClass modelClass
 @param whereStr 更新条件  
 @param updateModel updateModel
 @param resultError 错误结果
 */
+ (void)updateDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString*)whereStr  updateModel:(void(^)(id))updateModel Error:(void(^)(NSError *error))resultError;
@end
