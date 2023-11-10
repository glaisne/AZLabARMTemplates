$run = {
    cls
    $systems = @{
        'VM-A1' = '10.0.0.4'
        'VM-B1' = '10.1.0.4'
        'VM-C1' = '10.2.0.4'
        'VM-D1' = '10.3.0.4'
    }
    # $results = [System.Collections.ArrayList]::new()
    $results = foreach ($SystemName in $Systems.keys | sort)
    {
        [pscustomobject][ordered] @{
            $SystemName = $(test-netconnection $Systems[$SystemName] -InformationLevel Quiet -WarningAction 'SilentlyContinue')
        }
    }
    $results |fl
}
