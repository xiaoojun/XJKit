//
//  XJCoreDataManager.m
//  XJKitDemo
//
//  Created by 汤小军 on 2018/6/1.
//  Copyright © 2018年 汤小军. All rights reserved.
//

#import "XJCoreDataManager.h"

@interface XJCoreDataManager ()

/**
 对象管理上下文 作用: 插入数据，查询数据，删除数据，更新数据
 */
@property (nonatomic,strong) NSManagedObjectContext * context; //对象管理上下文
@end



@implementation XJCoreDataManager

static XJCoreDataManager *instance;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XJCoreDataManager alloc]init];
    });
    return instance;
}

- (instancetype)createCoreDataWithDB:(NSString *)DBName {
    
    ///这里对构建新版本的coredataModel有关键作用
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    //1. 创建模型对象
    //获取模型路径
    NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:DBName withExtension:@"momd"];
    //创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    
    //2. 创建持久化助理
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    //数据库名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbName = [NSString stringWithFormat:@"%@.sqlite",DBName];
    NSString *sqlPath = [docStr  stringByAppendingPathComponent:dbName];
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    NSLog(@"%@",sqlPath);
    
    //设置数据库相关信息
    NSError *error;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:optionsDictionary error:&error];
    
    if (error) {
        NSLog(@"打开数据库失败%@",error.localizedDescription);
    } else {
        //创建上下文
        [XJCoreDataManager shareManager].context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [[XJCoreDataManager shareManager].context setPersistentStoreCoordinator:store];
        NSLog(@"创建数据库成功！！！");
    }
    
    return self;
}

+ (void)inserDataWithCoreDataModelClass:(Class)modelClass CoreDataModel:(void (^)(id))CoreDataModel Error:(void (^)(NSError *))resultError {
    NSEntityDescription *classDescription = [NSEntityDescription entityForName:NSStringFromClass(modelClass) inManagedObjectContext:[XJCoreDataManager shareManager].context];
    id modelobject = [[modelClass alloc]initWithEntity:classDescription insertIntoManagedObjectContext:[XJCoreDataManager shareManager].context];
    CoreDataModel(modelobject);
    NSError *error = nil;
    [[XJCoreDataManager shareManager].context save:&error];
    resultError(error);
    
}

+ (void)fetchDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString*)whereStr arrResult:(void(^)(NSArray *resultArr))arrResult Error:(void(^)(NSError *error))resultError {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass(modelClass)];
    if (whereStr) {
         //条件查询
        NSPredicate *predicate = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = predicate;
    }
    NSError *error = nil;
    NSArray *result = [[XJCoreDataManager shareManager].context executeFetchRequest:request error:&error];
    arrResult(result);
    resultError(error);
}

 + (void)deleteDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString *)whereStr deleteResult:(void (^)(BOOL))deleteResult Error:(void (^)(NSError *))resultError{
    
    NSEntityDescription *entityDes = [NSEntityDescription  entityForName: NSStringFromClass(modelClass) inManagedObjectContext:[XJCoreDataManager shareManager].context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    if (whereStr) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = pre;
    }
    [request setIncludesPropertyValues:NO];
    request.entity = entityDes;
    NSError *error = nil;
    NSArray *datas = [[XJCoreDataManager shareManager].context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count]) {
        for (NSManagedObject *obj in datas) {
            [[XJCoreDataManager shareManager].context deleteObject:obj];
        }
        if (![[XJCoreDataManager shareManager].context save:&error]) {
            deleteResult(NO);
        } else {
            deleteResult(YES);
        }
    }
     resultError(error);
}

 + (void)updateDataWithCoreDataModelClass:(Class)modelClass fetchWhere:(NSString *)whereStr updateModel:(void (^)(id))updateModel Error:(void (^)(NSError *))resultError {
    NSEntityDescription *entityDes = [NSEntityDescription  entityForName: NSStringFromClass(modelClass) inManagedObjectContext:[XJCoreDataManager shareManager].context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    if (whereStr) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = pre;
    }
    [request setIncludesPropertyValues:NO];
    request.entity = entityDes;
    NSError *error = nil;
    NSArray *datas = [[XJCoreDataManager shareManager].context executeFetchRequest:request error:&error];
    for (id modelobject in datas) {
        
        updateModel(modelobject);
        [[XJCoreDataManager shareManager].context updatedObjects];
        
    }
}


@end
