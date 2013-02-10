#import "EJBindingCanvasGradient.h"
#import "EJConvertColorRGBA.h"

@implementation EJBindingCanvasGradient

+ (JSObjectRef)createJSObjectWithContext:(JSContextRef)ctx gradient:(EJCanvasGradient *)gradient {
	EJBindingCanvasGradient *binding = [[EJBindingCanvasGradient alloc] initWithContext:ctx argc:0 argv:NULL];
	binding->gradient = gradient;
	
	return [self createJSObjectWithContext:ctx instance:binding];
}

+ (EJCanvasGradient *)gradientFromJSValue:(JSValueRef)value {
	if( !value ) { return NULL; }
	
	EJBindingCanvasGradient *binding = JSValueGetNativeObject(value);
	return (binding && [binding isMemberOfClass:[EJBindingCanvasGradient class]]) ? binding->gradient : NULL;
}


EJ_BIND_FUNCTION(addColorStop, ctx, argc, argv) {
	if( argc < 2 ) { return NULL; }
	
	float offset = JSValueToNumberFast(ctx, argv[0]);
	if( offset < 0 || offset > 1 ) { return NULL; }
	
	EJColorRGBA color = JSValueToColorRGBA(ctx, argv[1]);
	
	[gradient addStopWithColor:color at:offset];
	return NULL;
}

@end
