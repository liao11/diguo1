
#import "ZhenD3ResponseObject_Entity.h"

@implementation ZhenD3ResponseObject_Entity

- (NSString *)description {
    return [NSString stringWithFormat:@"< %@:%p => code:%ld \n type=%ld \n msg=%@, \n result=%@ >",[self class], self, (long)self.zd32_responseCode, (long)self.zd32_responseType, self.zd32_responeMsg, self.zd32_responeResult];
}
@end
