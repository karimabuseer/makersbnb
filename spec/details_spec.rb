require 'details'

describe Details do
  it 'checks if password has a number' do
    number = Details.authenticate_password('Password1%')

    no_number = Details.authenticate_password('Password%')

    expect(number).to eq true
    expect(no_number).to eq false
  end

  it 'checks if password has an uppercase letter' do
    uppercase = Details.authenticate_password('Password1%')

    no_uppercase = Details.authenticate_password('password1%')

    expect(uppercase).to eq true
    expect(no_uppercase).to eq false
  end

  it 'checks if password has a lowercase letter' do
    lowercase = Details.authenticate_password('Password1%')

    no_lowercase = Details.authenticate_password('PASSWORD1%')

    expect(lowercase).to eq true
    expect(no_lowercase).to eq false
  end

  it 'checks if password has a length of between 8 and 32' do
    length = Details.authenticate_password('Password1%')

    no_length = Details.authenticate_password('Pass1%')

    expect(length).to eq true
    expect(no_length).to eq false
  end

  it 'checks if password contains a special character' do
    special = Details.authenticate_password('Password1%')

    no_special = Details.authenticate_password('Password1')

    expect(special).to eq true
    expect(no_special).to eq false
  end

end