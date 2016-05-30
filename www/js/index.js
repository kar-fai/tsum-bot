angular.module('mainApp', [])
.controller('mainController', function($scope, $http) {

    $scope.sortType     = 'frequency'; // set the default sort type
    $scope.sortReverse  = true;        // set the default sort order
    $scope.searchKey    = '';          // set the default search/filter term

    $http.get("data.csv").then(function(response){
        var csvArray = response.data.split(',');
        csvArray.pop();

        var frequency = {};

        for(var i=0; i<csvArray.length; i++){
            var tsumID = csvArray[i];
            frequency[tsumID] = frequency[tsumID] ? frequency[tsumID] + 1 : 1;
        }

        var tuples = []
        for (var tsumID in frequency) tuples.push({tsumID:tsumID, frequency:frequency[tsumID]});

        $scope.claimRecords = tuples;
    });
});
