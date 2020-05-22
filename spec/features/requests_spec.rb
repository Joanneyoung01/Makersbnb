feature 'requests' do
  scenario 'user can view requests made' do
    DatabaseConnection.query("INSERT INTO bookings (id, space_id, user_id, date, status) VALUES (1, 1, 2, '2020-10-20', 'unconfirmed')")
    DatabaseConnection.query("INSERT INTO bookings (id, space_id, user_id, date, status) VALUES (2, 2, 2, '2030-10-21', 'unconfirmed')")
    DatabaseConnection.query("INSERT INTO users (id, username, name, email, password) VALUES (2, 'James1989', 'James Bloogs', 'jbloogsy@hotmail.com', '#{BCrypt::Password.create('12345')}');")
    DatabaseConnection.query("INSERT INTO spaces (id, name, description, price, available_from, available_to, user_id) VALUES (3, 'Neptune', 'SOMETHING', '1200', '2030-10-10', '2040-10-12', 2);")
    DatabaseConnection.query("INSERT INTO spaces (id, name, description, price, available_from, available_to, user_id) VALUES (4, 'Jupiter', 'SOMETHING', '5000', '2020-10-10', '2040-10-12', 2);")
    DatabaseConnection.query("INSERT INTO bookings (id, space_id, user_id, date, status) VALUES (3, 3, 1, '2020-10-20', 'unconfirmed')")
    DatabaseConnection.query("INSERT INTO bookings (id, space_id, user_id, date, status) VALUES (4, 4, 1, '2020-10-20', 'unconfirmed')")
    visit('/users/log-in')
    fill_in('username', with: 'James1989')
    fill_in('password', with: '12345')
    click_button('submit')
    visit('/requests')
    expect(page).to have_content("You booked: Mars")
    expect(page).to have_content("You booked: Pluto")
    expect(page).to have_content("You received a request for your space Neptune from Joe1984")
    expect(page).to have_content("You received a request for your space Jupiter from Joe1984")
  end
end