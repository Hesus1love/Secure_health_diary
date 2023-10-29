// The 'healthy_diary' program.
program healthy_diary.aleo {
    struct String {
        data0: u128,
        data1: u128,
        data2: u128,
        data3: u128,
        data4: u128,
        data5: u128,
        data6: u128,
        data7: u128,
    }

    // Structure for Journal Entry
    struct DiaryEntry {
        date: String,
        health_note: String,
        medications: String,
        test_results: String,
    }

    // Displaying user addresses on their diary entries
    mapping user_diary_entries: address => DiaryEntry;

    // Adding an entry to a user's diary
    transition add_entry(
        user_address: address, 
        date: String, 
        health_note: String, 
        medications: String, 
        test_results: String
    ) {
        return then finalize(user_address, date, health_note, medications, test_results);
    }
    finalize add_entry(
        user_address: address, 
        date: String, 
        health_note: String, 
        medications: String, 
        test_results: String
    ) {
        let entry: DiaryEntry = DiaryEntry { 
            date: date, 
            health_note: health_note, 
            medications: medications, 
            test_results: test_results 
        };
        Mapping::set(user_diary_entries, user_address, entry);
    }

    // Retrieving an entry from a user's diary (only the user can view their entries)
    transition view_entry(user_address: address, requester_address: address) {
        return then finalize(user_address, requester_address);
    }
    finalize view_entry(user_address: address, requester_address: address) {
        assert_eq(user_address, requester_address); // Verify that the request is made by the user
        let entry: DiaryEntry = Mapping::get(user_diary_entries, user_address);
        // Return the record to the user (Note: Leo doesn't have a direct mechanism to return data, it's a logical representation)
    }
}

