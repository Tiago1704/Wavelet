## Copyright (C) 2019 Dany
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} wvlet8 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn
## since dim of fwt is 2 the fwt is applied to every column
##   the transform is applied to each row [W, Ls]=size(f).
## The output is then a matrix and the input orientation is preserved in
##  the orientation of the output coefficients. The dim paramerer has to
##  be passed to the WAVPACK2CELL and WAVCELL2PACK when used.
## Author: Tiago <tiago170497@gmail.com>
## Created: 2019-10-11

function retval = AplicoWvlet (input1,input2,input3, input4, canal)
% 
f = input1; % nombre del archivo csv a analizar
#f = "01.DO 1.wav";
% original [y, fs] = audioread (filename, samples, datatype)
#[f,fs] = audioread (input1);
#info =  [f, fs];

#info = aviread(input1, 1);

J = input2;  % la cantidad de coeficientes. Ej 10
#J = 10; 
wvNom = input3; % la wavelet a aplicar. Ej "db8" o 'db8'
#wvNom = "db8";

%como es dos canales lo reduzco a uno con pp=y(:,1);
#
#1
#[c,info] = fwt(f(:,canal),wvNom,J,1); %aplica la wavelet y devuelve c coeficientes  
fotograma = input4; %Número de fotogramas del video
imagen = aviread(input1, fotograma);
[c,info] = fwt(imagen(:,canal),wvNom,J,1);
#[c,info] = fwt(imagen(:,canal),wvNom,J,1);
#[c,info] = fwt(f(:,canal),wvNom,J);
#plotwavelets(c,info,fs,'dynrange',90);
#plotwavelets(c,info,imagen,'dynrange',90);
#plotwavelets(c,info,imagen,'dynrange',90);
#info = aviinfo ( input1 )

## Frequency bands of the transform with x-axis in a log scale and band
##  peaks normalized to 1. Only positive frequency band is shown.

[g,a] = wfbt2filterbank({wvNom,J,'dwt'});
filterbankfreqz(g,a,20*1024,'linabs','posfreq','plot','inf','flog');

%muestro la estructura de informacion de la señal
info
%devuelvo los coeficientes
retval=c;
endfunction
