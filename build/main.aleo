program healthy_diary.aleo;

struct String:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;
    data4 as u128;
    data5 as u128;
    data6 as u128;
    data7 as u128;

struct DiaryEntry:
    date as String;
    health_note as String;
    medications as String;
    test_results as String;


mapping user_diary_entries:
	key left as address.public;
	value right as DiaryEntry.public;

function add_entry:
    input r0 as address.private;
    input r1 as String.private;
    input r2 as String.private;
    input r3 as String.private;
    input r4 as String.private;

    finalize r0 r1 r2 r3 r4;

finalize add_entry:
    input r0 as address.public;
    input r1 as String.public;
    input r2 as String.public;
    input r3 as String.public;
    input r4 as String.public;
    cast r1 r2 r3 r4 into r5 as DiaryEntry;
    set r5 into user_diary_entries[r0];


function view_entry:
    input r0 as address.private;
    input r1 as address.private;

    finalize r0 r1;

finalize view_entry:
    input r0 as address.public;
    input r1 as address.public;
    assert.eq r0 r1;
    get user_diary_entries[r0] into r2;
