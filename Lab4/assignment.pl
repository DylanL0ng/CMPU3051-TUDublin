% declare predicates and their arity 
:- dynamic invest_in/1.
:- dynamic savings_account/1.
:- dynamic min_savings/2.
:- dynamic min_income/2.
:- dynamic max_debt/2.
:- dynamic earnings/2.

% rule 1 - if users savings amount is inadequate then they will be advised 
% to invest in savings
invest_in(savings) :- 
	savings_account(inadequate).
	

% rule 2 - if users savings amount is adequate and their income is adequate 
% then they will be advised to invest in stocks
invest_in(stocks) :- 
	savings_account(adequate), 
	income(adequate).


% rule 3 - if users savings amount is adequate and users income is inadequate
% then they will be advised to invest in a combination
invest_in(combination) :- 
	savings_account(adequate), 
	income(inadequate).


% rules 4 & 5 - if users savings amount is less than or equal to mimimum savings 
% then savings_account is inadequate
savings_account(A) :-
	amount_saved(S),
	num_dependents(D),
	min_savings(D, MS),
	(S > MS,
	A = adequate;
	S =< MS, 
	A = inadequate).


% rules 6 & 7 - if users income is less then or equal to minimum income
% then income is inadequate 
income(A) :-
	earnings(E, steady),
	num_dependents(D),
	min_income(D, MI),
	(E > MI, 
	A = adequate;
	E =< MI,
	A = inadequate).


% rule 8 - if earnings is unsteady then income is inadequate
income(inadequate) :- 
	earnings(E, unsteady).
	
% rule 9 - new rule - if users debt is greater than the maximum debt they can be in
% then savings_account is inadequate
savings_account(inadequate) :-
	current_debt(D),
	amount_saved(S),
	max_debt(S, DM),
	D > DM.


% function to get the minimum savings amount
min_savings(D, MS) :- 
	MS is 5000 * D.

% function to get the minimum income amount
min_income(D, MI) :- 
	MI is (4000 * D) + 15000.
	
% function to get the maximum debt amount
max_debt(S, DM) :-
	DM is S / 2.

% function to get user to input their savings amount
getSavings :-
	write('Enter savings amount: '),
	read(S),
	assert(amount_saved(S)).


% function to get user to input their number of dependents
getDependents :-
	write('Enter number of dependents: '),
	read(D),
	assert(num_dependents(D)).
	
	
% function to get user to input their earnings
getEarnings :-
	write('Enter your earnings: '),
	read(E),
	assert(earnings(E, steady)).
	
% extra rule
% function to get the user to input their current debt
getDebt :-
	write('Enter your current debt: '),
	read(D),
	assert(current_debt(D)).	

% function to check if the advice is to invest in stocks
shouldInvestInStocks(B) :-
	invest_in(X),
	(X == stocks,
	B = true;
	B = false).

% go is to run the whole program
go :-
	getSavings,
	getDependents,
	getEarnings,
	getDebt,
	
	write('\n'),
	
	invest_in(X),
	write('Advice is to invest in: '),
	write(X),
	
	write('\n\n'),
	
	shouldInvestInStocks(B),	
	!,
	cleanInputs.
	
cleanInputs :- 
	retractall(amount_saved(_)),
	retractall(num_dependents(_)),
	retractall(earnings(_)),
	retractall(current_debt(_)).