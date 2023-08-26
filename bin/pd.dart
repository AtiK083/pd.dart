abstract class Account {
  int accountNumber;
  double balance;

  Account(this.accountNumber, this.balance);

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print("Deposited $amount. New balance: $balance");
    } else {
      print("Invalid deposit amount.");
    }
  }

  // Abstract method, to be implemented by subclasses
  void withdraw(double amount);
}

class SavingsAccount extends Account {
  double interestRate;

  SavingsAccount(int accountNumber, double balance, this.interestRate)
      : super(accountNumber, balance);

  @override
  void withdraw(double amount) {
    if (amount <= balance) {
      balance -= amount;
      balance += balance * interestRate; // Apply interest
      print("Withdrawn $amount. New balance: $balance");
    } else {
      print("Insufficient balance.");
    }
  }
}

class CurrentAccount extends Account {
  double overdraftLimit;

  CurrentAccount(int accountNumber, double balance, this.overdraftLimit)
      : super(accountNumber, balance);

  @override
  void withdraw(double amount) {
    if (amount <= balance + overdraftLimit) {
      balance -= amount;
      print("Withdrawn $amount. New balance: $balance");
    } else {
      print("Exceeds overdraft limit. Insufficient funds.");
    }
  }
}

void main() {
  // Create a Savings Account
  var savings = SavingsAccount(12345, 1000.0, 0.05);
  print("Savings Account - Initial balance: ${savings.balance}");
  savings.deposit(500.0);
  savings.withdraw(200.0);

  // Create a Current Account
  var current = CurrentAccount(67890, 2000.0, 1000.0);
  print("Current Account - Initial balance: ${current.balance}");
  current.deposit(300.0);
  current.withdraw(3000.0);
}
