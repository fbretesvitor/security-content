## Revoke Entra ID user tokens

The following playbook intends to revert entra id user tokens

## Purpose

When a user got risky status, the SOC team can automatically refresh all entra id tokens to require target user to re-authenticate

## Requirements

The following table present the requirements:
| Resource                    |  Permissions                               	   | Notes  	                                                    |
| ----------------------------| -------------------------------------------------- | ---------------------------------------------------------------| 
| **System Managed identity** | Key Vault Secrets user                     	   | Is the playbook ID. Only available after the deployment 	    |
| **App registration**        | Microsoft Graph \ Application \ User.ReadWrite.All | Add secret to Azure Key Vault                          	    | 
| **Azure Key Vault**         |                                            	   | Key Vault to host secrets to be consumed by Sentinel playbooks |

### Kudos to https://github.com/Azure/Azure-Sentinel/blob/master/Playbooks/AS-Revoke-Azure-AD-User-Session-From-Entity/azuredeploy.json who played a significant part!
