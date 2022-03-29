# in case you have multiple subscriptions...
select-azsubscription -SubscriptionName "anfcorp-shared-services"


# get all non-compliant policies that can be remediated
$nonCompliantPolicies = Get-AzPolicyState | Where-Object { $_.ComplianceState -eq "NonCompliant" -and $_.PolicyDefinitionAction -eq "deployIfNotExists" }

# loop through ans start individual tasks per policy 
foreach ($policy in $nonCompliantPolicies) {

    $remediationName = $policy.PolicyDefinitionName
    Start-AzPolicyRemediation -Name $remediationName -PolicyAssignmentId $policy.PolicyAssignmentId -PolicyDefinitionReferenceId $policy.PolicyDefinitionReferenceId
}