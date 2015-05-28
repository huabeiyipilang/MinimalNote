//
//  NoteManager.m
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "NoteManager.h"
#import "FMDatabase.h"

@implementation NoteManager{
    FMDatabase* mDatabase;
}

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    NoteManager* instance = [super init];
    NSString* dbDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbPath = [dbDir stringByAppendingPathComponent:@"note.db"];
    mDatabase = [FMDatabase databaseWithPath:dbPath];
    if ([mDatabase open]) {
        NSString* noteLabel = @"CREATE TABLE Note (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,title text,content text,create_time integer,modify_time integer,deleted integer(1));";
        [self excuteUpdate:noteLabel];
    }else{
        NSLog(@"Could not open db.");
    }

    return instance;
}


- (BOOL)addNote:(Note*) note{
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO Note (title, content, create_time, modify_time, deleted) VALUES (\"%@\", \"%@\", %f, %f, %d)", note.title, note.content, time, time, 0];
    return [self excuteUpdate:sql];
}

- (BOOL)updateNote:(Note*) note{
    NSString* sql = [NSString stringWithFormat:@"update Note set title=\"%@\", content=\"%@\", modify_time=%f, deleted=%d where id=%ld", note.title, note.content, [NSDate date].timeIntervalSince1970, note.deleted, (long)note.nid];
    return [self excuteUpdate:sql];
}

- (BOOL)deleteNote:(Note*) note{
    
    return YES;
}

- (BOOL)excuteUpdate:(NSString*)sql{
    NSLog(sql,nil);
    return [mDatabase executeUpdate:sql];
}

- (NSMutableArray*)getAllNotesWithDeleted:(BOOL)all{
    NSString* sql = @"select * from note";
    if (!all) {
        sql = [sql stringByAppendingString:@" where deleted=0"];
    }
    sql = [sql stringByAppendingString:@" ORDER BY create_time DESC"];
    FMResultSet* result = [mDatabase executeQuery:sql];
    NSMutableArray* notes = [NSMutableArray new];
    Note* note = nil;
    while ([result next]) {
        note = [Note new];
        note.nid = [result intForColumn:@"id"];
        note.title = [result stringForColumn:@"title"];
        note.content = [result stringForColumn:@"content"];
        note.create_time = [[NSDate alloc] initWithTimeIntervalSince1970:[result doubleForColumn:@"create_time"]];
        note.modify_time = [[NSDate alloc] initWithTimeIntervalSince1970:[result doubleForColumn:@"modify_time"]];
        note.deleted = [result intForColumn:@"deleted"] == 1 ? YES : NO;
        [notes addObject:note];
    }
    
    return notes;
}

@end
