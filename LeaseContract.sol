pragma solidity ^0.5.0;

contract LeaseContract{
    enum ResidentialType {
        CONDO,
        APARTMENT,
        TOWNHOME,
        HOUSE
    }
    string[] rules;
    struct ResidentAddress{
        string addressLine1;
        string addressLine2;
        string city;
        string state;
        string postalCode;
        string country;
    }
    struct Tenant{
        string name;
        address payable tenantAddr;
        uint leaseStartDate;
        //leaseEndDate= leaseStartDate + 365 days
        uint leaseEndDate ;
        uint leaseSignedDate;
        uint rentalAmount;
        uint depositAmount;
    }
    struct ResidentDetails{
        ResidentAddress addr;
        uint numberOfBendrooms;
        uint numberofBathrooms;
        string areaInSqft;
        ResidentialType residentialType;
    }
    struct OwnerDetails{
        address payable owner;
        string ownerName;
    }

    OwnerDetails landlord;
    ResidentDetails residentDetails;
    ResidentAddress residentAddr;
    Tenant tenant;

    modifier onlyLandLord(address _owner){
        require (landlord.owner == _owner, "Only landlord can list the house.");
        _;
    }

    constructor(address payable _owner, string memory _ownerName)public {
        landlord.owner = _owner;
        landlord.ownerName = _ownerName;
    }

    function populateResidentDetails(
        address _owner,
        uint _numberOfBedrooms,
        uint _numberOfBathrooms,
        string memory _areaInSqft,
        uint  _residentialType,
        string memory _addressLine1,
        string memory _addressLine2,
        string memory _city,
        string memory _state,
        string memory _postalCode,
        string memory _country) public onlyLandLord(_owner){
        residentAddr = populateResidentAddress(_addressLine1,
        _addressLine2,_city,_state,_postalCode,_country);
        ResidentialType residentType = getResidentialType(_residentialType);
        residentDetails = ResidentDetails(residentAddr,_numberOfBedrooms,
                _numberOfBathrooms,_areaInSqft,residentType);
    }   

    function getResidentialType(uint  _residentialType) private pure returns(ResidentialType){
        return _residentialType == 0 ? ResidentialType.CONDO :
            _residentialType == 1 ? ResidentialType.APARTMENT :
            _residentialType == 2 ? ResidentialType.TOWNHOME :
            ResidentialType.HOUSE;
    }

    function populateResidentAddress(
        string memory _addressLine1,
        string memory _addressLine2,
        string memory _city,
        string memory _state,
        string memory _postalCode,
        string memory _country) private returns (ResidentAddress memory){

        return ResidentAddress(
            _addressLine1,
            _addressLine2,
            _city,
            _state,
            _postalCode,
            _country);
    }

    function populateRules (string memory _rule) public {
        rules.push(_rule);
    }

    function addTenantDetails(
        address _owner,
        string memory _name,
        address payable _tenantAddr,
        uint _leaseStartDate,
        uint _leaseEndDate ,
        uint _leaseSignedDate,
        uint _rentalAmount,
        uint _depositAmount
        ) public onlyLandLord(_owner) {
            tenant = Tenant(
            _name,_tenantAddr,_leaseStartDate,
            _leaseEndDate,_leaseSignedDate,
            _rentalAmount,_depositAmount);
    }
    modifier onlyTenant(address _tenant){
        require(tenant.tenantAddr == _tenant, "Only Tenant is allowed to make a deposit.");
        _;
    }

    function deposit(address _tenant) public onlyTenant(_tenant){

    }

}