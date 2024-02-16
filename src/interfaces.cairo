use starknet::ContractAddress;

#[derive(Drop, Serde, starknet::Store)]
struct User {
    address: ContractAddress,
    first_name: felt252,
    last_name: felt252,
    about_yourself: felt252,
    phone_number: felt252,
    email: felt252,
    property_count: u256,
}

#[derive(Drop, Serde, starknet::Store)]
struct Property {
    owner: ContractAddress,
    is_available: bool,
    title: felt252,
    description: felt252,
    status: felt252,
    price: u128,
    area: u128,
    name: felt252,
    username: felt252,
    email: felt252,
    phone: felt252,
    address: felt252,
    city: felt252,
    state: felt252,
    county: felt252,
    lat: u32,
    long: u32
}


//defina all your traits  here.
//major functions :add user,addproperty,trasfer property
#[starknet::interface]
trait IRealEstate<TContractState> {
    // User management
    fn add_user(
        ref self: TContractState,
        first_name: felt252,
        last_name: felt252,
        about_yourself: felt252,
        phone_number: felt252,
        email: felt252
    );

    // Property management
    fn add_property(
        ref self: TContractState,
        is_available: bool,
        title: felt252,
        description: felt252,
        status: felt252,
        price: u128,
        area: u128,
        name: felt252,
        username: felt252,
        email: felt252,
        phone: felt252,
        address: felt252,
        city: felt252,
        state: felt252,
        county: felt252,
        lat: u32,
        long: u32
    );

    // Property transfer
    fn transfer_property_using_account(
        ref self: TContractState, property_id: u256, to_account_address: ContractAddress
    );
    //get_property_all
    fn get_property_all(self: @TContractState)-> u128;
}
