#[starknet::contract]
mod RealEstateContract {
    use starknet::{get_caller_address, ContractAddress};
    use smartland_contract::interfaces::{IRealEstate, User, Property};

    #[storage]
    struct Storage {
        users: LegacyMap<ContractAddress, User>,
        user_properties: LegacyMap<(ContractAddress, u256), u256>,
        properties: LegacyMap<u256, Property>,
        property_count: u256,
    }

    #[abi(embed_v0)]
    impl RealEstate of IRealEstate<ContractState> {
        // User addition logic
        fn add_user(
            ref self: ContractState,
            first_name: felt252,
            last_name: felt252,
            about_yourself: felt252,
            phone_number: felt252,
            email: felt252
        ) {
            // Implementation to store user data
            let caller_address = get_caller_address();
            let user = User {
                address: caller_address,
                first_name,
                last_name,
                about_yourself,
                phone_number,
                email,
                property_count: 0
            };

            self.users.write(caller_address, user);
        }

        // Property addition logic
        fn add_property(
            ref self: ContractState,
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
        ) {
            // Implementation to store property data
            let prop_id = self.property_count.read() + 1;
            let caller_address = get_caller_address();
            let mut user = self.users.read(caller_address);
            let user_prop_count = user.property_count + 1;
            user.property_count += 1;
            let property = Property {
                owner: caller_address,
                is_available,
                title,
                description,
                status,
                price,
                area,
                name,
                username,
                email,
                phone,
                address,
                city,
                state,
                county,
                lat,
                long
            };
            self.properties.write(prop_id, property);
            self.property_count.write(prop_id);
            self.users.write(caller_address, user);
            self.user_properties.write((caller_address, user_prop_count), prop_id);
        }
        // Property transfer logic
        fn transfer_property_using_account(
            ref self: ContractState, property_id: u256, to_account_address: ContractAddress
        ) { // Implementation to transfer property
            let mut new_user = self.users.read(to_account_address);
            let mut prop = self.properties.read(property_id);
            let caller_address = get_caller_address();

            assert(new_user.address == to_account_address, 'New user not found');
            assert(prop.owner == caller_address, 'Not your property');

            prop.owner = to_account_address;
            self.properties.write(property_id, prop);

            let new_user_prop_count = new_user.property_count + 1;
            new_user.property_count += 1;

            self.user_properties.write((to_account_address, new_user_prop_count), property_id);
        }

       
         //get_property_all
        fn get_property_all(self: @ContractState) -> u128 {
            // self.Property.read()
        0

        
    }
    }
}


