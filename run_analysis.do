	rename ThayđổicủaVNIndexsovớingàyhômtrư VNINDEX
	rename ThayđổicủaTỷgiásovớingàyhômtrước USD_VND
	rename LãisuấtFED FED
	rename Thayđổicủagiávàngsovớihômtrước AUD
	rename Thayđổicủagiádầusovớihômtrước WTI

	destring VNINDEX, ignore("%,") replace
	destring USD_VND, ignore("%,") replace
	destring FED, ignore("%,") replace
	destring AUD, ignore("%,") replace
	destring WTI, ignore("%,") replace

	twoway line VNINDEX TIME
	generate TIME1 = _n

	describe
	summarize
	clear all

	use "C:\Users\ADMIN\Downloads\VNINDEX.dta"

	 
	use "C:\Users\ADMIN\Downloads\VNIdatachaymohinh.dta"

	gen quarterly = qofd(TIME)

	format quarterly %tq

	gen month = month(TIME)

	gen day=day(TIME)

	gen year=year(TIME)

	gen monthly = ym(year,month)

	format monthly %tm
	bysort monthly (TIME): keep if _n == _N
	tsset monthly, monthly
	
	wntestb VNINDEX
	cumsp VNINDEX
	wntestq VNINDEX
	reg VNINDEX USD_VND AUD WTI
	estat hettest
 
	corrgram VNINDEX , lags(12)

	var VNINDEX USD_VND AUD
	twoway (tsline VNINDEX)
	dfuller VNINDEX, lags(0)
	dfuller VNINDEX, lags(0)
	dfuller USD_VND, lags(0)
	dfuller AUD, lags(0)
	dfuller WTI, lags(0)
	reg VNINDEX monthly
	estat sbsingle
	dfuller VNINDEX, lags(5)
	dfuller d.VNINDEX, lags(5)
	
	quietly var VNINDEX USD_VND, lags(1/4)
	vargranger
	var VNINDEX USD_VND, lags(1/4)
	
	wntestq VNINDEX
	egranger VNINDEX USD_VND, ecm
	arima VNINDEX, ar(1) ma(1)
	arima VNINDEX, ar(3) ma(1)
	corrgram VNINDEX, lag (30)
	arima VNINDEX, ar(3) ma(3)
	arima VNINDEX, ar(3) ma(1)
	arima VNINDEX, ar(3) ma(4)

	use "C:\Users\ADMIN\Downloads\VNINDEX.dta"
	tsset TIME1, monthly
	dfuller VNINDEX, lags(0)
	dfuller VNINDEX, lags(5)
	dfuller USD_VND, lags(0)
	dfuller AUD, lags(0)
	dfuller WTI, lags(0)
	arimaauto VNINDEX
	corrgram VNINDEX, lag (20)
	arimaauto VNINDEX
	arima VNINDEX, ar(1) ma(2)
	arima VNINDEX, ar(2) ma(2)
	arima VNINDEX, ar(1) ma(1)

	*MH ARCH GARCH
	predict re, residuals
	tsline re
	reg re
	estat archlm
	estat archlm, lags(3)
	reg VNINDEX
	estat archlm
	mgarch ccc (VNINDEX USD_VND WTI = L.VNINDEX L.USD_VND L.WTI , noconstant), arch(5) garch(5)
	mgarch ccc (VNINDEX USD_VND WTI = L.VNINDEX L.USD_VND L.WTI , noconstant), arch(1) garch(1)
	*5/3/2025 quarterly month day year monthly
	//_egresid
	//re
	//re_10
	egranger VNINDEX USD_VND
	egranger VNINDEX AUD
	egranger VNINDEX WTI
	reg VNINDEX
	estat archlm
	arch VNINDEX, arch(1)
	arch VNINDEX, arch(1/2)
	arch VNINDEX, arch(3)
	var VNINDEX USD_VND AUD WTI, lags(1/1)
	var VNINDEX USD_VND AUD WTI, lags(1/2)
	var VNINDEX USD_VND AUD WTI, lags(1/3)
	varsoc VNINDEX USD_VND AUD WTI
	varsoc VNINDEX USD_VND AUD WTI, maxlag(10)
	var VNINDEX USD_VND AUD WTI, lags(1/10)
	predict re_10, residual
	sum re_10
	tsline re, yline(-1.58e-10)
	tsline re_10, yline(-1.58e-10)
	varlmar
	quietly var VNINDEX USD_VND AUD WTI, lags(1/10)
	quietly var VNINDEX USD_VND AUD WTI, lags(1/10)
	varstable
	quietly var VNINDEX USD_VND AUD WTI, lags(1/10)
	vargranger
	varlmar
	varlmar, mlag(10)
	varnorm
	varstable
	
	varbasic VNINDEX, lags(1/2) step(8) irf
	
	*Hàm phản ứng xung
	irf set "irf"
	irf create irfn
	irf graph irf, irf(irfn) impulse( VNINDEX USD_VND AUD WTI)
	irf table irf, irf(irfn) impulse( VNINDEX USD_VND AUD WTI)
	*VECM
	pergram VNINDEX
	vecrank VNINDEX USD_VND AUD WTI
	vecrank VNINDEX USD_VND AUD WTI
	vec VNINDEX USD_VND AUD WTI
	vec VNINDEX USD_VND WTI
	veclmar
	veclmar, mlag(4)
	vecnorm, jbera skewness kurtosis