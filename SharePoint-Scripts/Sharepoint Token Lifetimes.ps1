#######WindowsTokenLifetime
#This lifetime applies to user sessions authenticated with Windows Integrated Authentication (NTLM/Kerberos).
#The default value is 10 hours.
###########################################
$sts = Get-SPSecurityTokenServiceConfig
$sts.WindowsTokenLifetime = New-TimeSpan -Hours 10
$sts.Update()

#######FormsTokenLifetime
#The same as above but applies to Forms/FBA authentication sessions.
#The default value is also 10 hours.
######################################
$sts = Get-SPSecurityTokenServiceConfig
$sts.FormsTokenLifetime = New-TimeSpan -Hours 10
$sts.Update()

#######LogonTokenCacheExpirationWindow
#The lifetime of a token in the cache is deducted the window value when checking if it is expired. This means that the real lifetime of the token will be less than expected. The following diagram can be helpful to understand when a token is valid and the roles the lifetime and window play in the expiration.
#The default value for the expiration window is 10 minutes.
#So LogonTokenCacheExpirationWindow has to be smaller than the WindowsTokenLifetime! so that Sharepoint can update the security token after it is expired.
######################
$sts = Get-SPSecurityTokenServiceConfig
$sts.LogonTokenCacheExpirationWindow = New-TimeSpan -Minutes 10
$sts.Update()

#######CookieLifetime
#When using FBA or a trusted provider, SharePoint will set a cookie on the client called FedAuth. I'll not go into the details of what's inside the FedAuth cookie. Of course, the FedAuth cookie will have by default a certain lifetime. Session cookies can be configured too making the cookie invalid after the closing the browser and then bypassing the value in this settings.
#The default value is 5 days.
####################################
$sts = Get-SPSecurityTokenServiceConfig
$sts.CookieLifetime = New-TimeSpan -Days 5
$sts.Update()

#So, if we are using a trusted provider, for example, AD FS, how do we control how long the token will be valid? It will depend on how you can configure the STS that creates the token but if it is AD FS then you can set this in the Relying Party configuration.

#######ADFS RP's TokenLifetime#######
#This setting will change for how long the security token created by AD FS is valid. SharePoint will use this lifetime and set its security token lifetime to the same value.
#The default value is 60 minutes (which appears as 0 if the setting has not been changed in the RP).
#You can check the current settings with:

Get-AdfsRelyingPartyTrust | ft -auto Name,TokenLifetime

#And to change the value for a RP:

Set-AdfsRelyingPartyTrust -TargetName "SharePoint 2013" -TokenLifetime 30

#These are the main settings related to session lifetimes when dealing with user authentication. There are other values for applications and services but are kind of exotic and you won't usually need to change those.
 
#######Token-timeout#######
#SharePoint stores in the content database a token of the user that includes some claims like group memberships. This token needs to be refreshed from time to time to make features like "Check permissions" and other some security trimmed features work as expected.

#These tokens will be refreshed at least every 24 hours. Some operations that require having a fresher token, like "Check permissions", will refresh the token at least every 60 minutes.

#TokenTimeout will change the default 24 hours timeout to a greater or smaller amount. If the value is still greater than 60 minutes, some operations will still use 60 minutes as minimum.

$cs = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
$cs.TokenTimeout = New-TimeSpan -Minutes 5
$cs.Update()


#Default sharepoint token lifetimes
#
#SecurityTokenServicePublicUrlSuffix         : /_vti_bin/spsecuritytokenserviceactive.svc
#SecurityTokenServiceMetadataPublicUrlSuffix : /_vti_bin/spsecuritytokenserviceactive.svc/mex
#LocalLoginProvider                          : SPLocalLoginProvider Name=SharePoint
#TrustedLoginProviderNames                   : {}
#TrustedLoginProviders                       : {}
#TrustedAccessProviders                      : {}
#TrustedSecurityTokenServices                : {}
#DefaultTrustedSecurityTokenIssuer           :
#AuthenticationPipelineClaimMappingRules     : {WindowsMappingRule}
#AllowMetadataOverHttp                       : False
#UseSessionCookies                           : False
#WindowsTokenLifetime                        : 10:00:00
#FormsTokenLifetime                          : 10:00:00
#CookieLifetime                              : 5.00:00:00
#CookieLifetimeRefreshWindow                 : 4.00:00:00
#ServiceTokenLifetime                        : 10:00:00
#MaxLogonTokenCacheItems                     : 250
#MaxLogonTokenOptimisticCacheItems           : 100000
#LogonTokenCacheExpirationWindow             : 00:10:00
#MaxServiceTokenCacheItems                   : 250
#MaxServiceTokenOptimisticCacheItems         : 100000
#ServiceTokenCacheExpirationWindow           : 00:10:00
#ApplicationTokenLifetime                    : 1.12:00:00
#AuthenticatorTokenLifetime                  : 1.12:00:00
#MinApplicationTokenCacheItems               : 250
#MaxApplicationTokenCacheItems               : 100000
#ApplicationTokenCacheExpirationWindow       : 00:10:00
#ImplicitFlowTokenLifetime                   : 30.00:00:00
#LoopbackTokenLifetime                       : 10:00:00
#ProofTokenLifetime                          : 1.00:00:00
#IdentityTokenLifetime                       : 00:20:00
#SuppressModernAuthForOfficeClients          : True
#ActivateOkResponseToCORSOptions             : False
#AllowOAuthOverHttp                          : False
#BypassIdentityProviderForAppWebs            : True
#CookieValueHandlerType                      : Microsoft.SharePoint.IdentityModel.SPSessionSecurityTokenCookieValue
#NameIdentifier                              : 
#PidEnabled                                  : True
#HybridStsSelectionEnabled                   : True
#Name                                        : SecurityTokenServiceManager
#TypeName                                    : Microsoft.SharePoint.Administration.Claims.SPSecurityTokenServiceManager
#DisplayName                                 : SecurityTokenServiceManager
#Id                                          : 
#Status                                      : Online
#Parent                                      : SPSecurityTokenService Name=SecurityTokenService
#Version                                     : 3079
#DeploymentLocked                            : False
#Properties                                  : {}
#Farm                                        : SPFarm Name=SharePoint_Config
#UpgradedPersistedProperties                 : {}
#CanSelectForBackup                          : True
#DiskSizeRequired                            : 0
#CanSelectForRestore                         : True
#CanRenameOnRestore                          : False
#
#
#Default sharepoint token timeout
#
#Days              : 1
#Hours             : 0
#Minutes           : 0
#Seconds           : 0
#Milliseconds      : 0
#Ticks             : 864000000000
#TotalDays         : 1
#TotalHours        : 24
#TotalMinutes      : 1440
#TotalSeconds      : 86400
#TotalMilliseconds : 86400000







#for user profile sync groups custom token service config
$STSConfig = Get-SPSecurityTokenServiceConfig
$STSConfig.WindowsTokenLifetime = (New-TimeSpan -minutes 60)
$STSConfig.LogonTokenCacheExpirationWindow = (New-TimeSpan -minutes 30)
$STSConfig.Update()
