% Filtration with IIR for Equalization
% Analysis of IIR Filtration in terms of Replacing and minimum order
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Authors:
%   Hafiz Muhammad Attaullah - attaullahshafiq10@gmail.com
%   Alishba Butt - alishbab673@gmail.com
%   Aiza Abbasi - aizaabbasi911@gmail.com
%   Umm-e-Farwa - ummyfarwa110@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lowpass Filters
% First, we design a Butterworth filter
fdB = .2;
X = 4;
d = fdesign.lowpass('N,F3dB',X,fdB);
Hbutter = design(d,'butter','SystemObject',true);
% Now Chebyshev, to allow ripples in the passband to be controlled. No waves on the stopband are yet.
Ap = .5;
setspecs(d,'N,F3dB,Ap',X,fdB,Ap);
Hcheby1 = design(d,'cheby1','SystemObject',true);
hfvt = fvtool(Hbutter,Hcheby1,'Color','white');
axis([0 .44 -5 .1])
legend(hfvt,'Butterworth','Chebyshev Type I');
%Chebyshev TypeII design It allows the stopband attenuation to be managed.
Ast = 80;
setspecs(d,'N,F3dB,Ast',X,fdB,Ast);
Hcheby2 = design(d,'cheby2','SystemObject',true);
hfvt = fvtool(Hbutter,Hcheby2,'Color','white');
axis([0 1 -90 2])
legend(hfvt,'Butterworth','Chebyshev Type II');
% Finally, An elliptical filter can provide a steeper roll-off compared to previous designs by allowing both the stopband and the passband to ripple.
setspecs(d,'N,F3dB,Ap,Ast',X,fdB,Ap,Ast);
Hellip = design(d,'ellip','SystemObject',true);
hfvt = fvtool(Hbutter,Hcheby1,Hcheby2,Hellip,'Color','white');
axis([0 1 -90 2])
legend(hfvt, ...
    'Butterworth','Chebyshev Type I','Chebyshev Type II','Elliptic');
% Now set the access
axis([0 .44 -5 .1])
% Group Delay checking
hfvt.Analysis = 'grpdelay';

% Minimum Order Designs
Ap = 1;
Ast = 60;
Fp = .1;
Fst = .3;

setspecs(d,'Fp,Fst,Ap,Ast',Fp,Fst,Ap,Ast);
Hbutter = design(d,'butter','SystemObject',true);
Hcheby1 = design(d,'cheby1','SystemObject',true);
Hcheby2 = design(d,'cheby2','SystemObject',true);
Hellip = design(d,'ellip','SystemObject',true);
hfvt = fvtool(Hbutter,Hcheby1,Hcheby2,Hellip, 'DesignMask', 'on',...
    'Color','white');
axis([0 1 -70 2])
legend(hfvt, ...
    'Butterworth','Chebyshev Type I','Chebyshev Type II','Elliptic');

% 7th, 6th, 5th order (Chebyshev techniques)
order(Hbutter)
order(Hcheby1)
order(Hcheby2)
order(Hellip)

% Now Matching the Passband or Stopband Specifications
Hellipmin1    = design(d, 'ellip', 'MatchExactly', 'passband',...
    'SystemObject',true);
Hellipmin2 = design(d, 'ellip', 'MatchExactly', 'stopband',...
    'SystemObject',true);
hfvt = fvtool(Hellip, Hellipmin1, Hellipmin2, 'DesignMask', 'on',...
    'Color','white');
axis([0 1 -80 2]);
legend(hfvt, 'Matched passband and stopband', ...
    'Matched passband', 'Matched stopband', ...
    'Location', 'Northeast')

% compare passband edges
axis([0 .11 -1.1 0.1]);
legend(hfvt, 'Location', 'Southwest')

% verifying that, resulting order of filters are not changed
order(Hellip)
order(Hellipmin1)
order(Hellipmin2)

% Now finally. Highpass, Bandpass and Bandstop Filters
d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
    .35,.45,.55,.65,60,1,60);
Hbutter = design(d,'butter','SystemObject',true);
Hcheby1 = design(d,'cheby1','SystemObject',true);
Hcheby2 = design(d,'cheby2','SystemObject',true);
Hellip = design(d,'ellip','SystemObject',true);
hfvt = fvtool(Hbutter,Hcheby1,Hcheby2,Hellip, 'DesignMask', 'on',...
    'Color','white');
axis([0 1 -70 2])
legend(hfvt, ...
    'Butterworth','Chebyshev Type I','Chebyshev Type II','Elliptic',...
    'Location', 'Northwest')

%end
% 17 january 2021

