/**
 * Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
 *
 * You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
 * copy, modify, and distribute this software in source code or binary form for use
 * in connection with the web services and APIs provided by Facebook.
 *
 * As with any software that integrates with the Facebook platform, your use of
 * this software is subject to the Facebook Developer Principles and Policies
 * [http://developers.facebook.com/policy/]. This copyright notice shall be
 * included in all copies or substantial portions of the software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @format
 */
import { RNFBSDKCallback } from './models/FBSDKCallback';
/**
 * Indicates which default audience to use for sessions that post data to Facebook.
 */
export declare type DefaultAudience = 'friends' | 'everyone' | 'only_me';
export declare type LoginBehavior = LoginBehaviorIOS | LoginBehaviorAndroid;
/**
 * Indicate how Facebook Login should be attempted on Android.
 */
export declare type LoginBehaviorAndroid = 'native_with_fallback' | 'native_only' | 'web_only';
/**
 * Indicate how Facebook Login should be attempted on iOS.
 */
export declare type LoginBehaviorIOS = 'browser';
/**
 * Shows the results of a login operation.
 */
export declare type LoginResult = RNFBSDKCallback & {
    grantedPermissions?: Array<string>;
    declinedPermissions?: Array<string>;
};
export declare type LoginTracking = 'enabled' | 'limited';
declare const _default: {
    /**
     * Log in with the requested permissions.
     * @param loginTrackingIOS IOS only: loginTracking: 'enabled' | 'limited', default 'enabled'.
     * @param nonceIOS IOS only: Nonce that the configuration was created with. A unique nonce will be used if none is provided to the factory method.
     */
    logInWithPermissions(permissions: Array<string>, loginTrackingIOS?: LoginTracking, nonceIOS?: string): Promise<LoginResult>;
    /**
     * Getter for the login behavior.
     */
    getLoginBehavior(): Promise<LoginBehavior>;
    /**
     * Setter for the login behavior.
     */
    setLoginBehavior(loginBehavior: LoginBehavior): void;
    /**
     * Getter for the default audience.
     */
    getDefaultAudience(): Promise<DefaultAudience>;
    /**
     * Setter for the default audience.
     */
    setDefaultAudience(defaultAudience: DefaultAudience): void;
    /**
     * Re-authorizes the user to update data access permissions.
     */
    reauthorizeDataAccess(): Promise<LoginResult>;
    /**
     * Logs out the user.
     */
    logOut(): void;
};
export default _default;
