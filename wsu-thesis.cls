% Washington State University thesis/dissertation class
% LaTeX document class v0.1
% JMcDonald1@wsu.edu
%Import the natbib package and sets a bibliography  and citation styles
\usepackage{natbib}
\bibliographystyle{apa-good}
\setcitestyle{authoryear,open={(},close={)}} %Citation-related commands

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wsu-thesis}[2020/03/01 v0.1 Washington State University thesis/dissertation class]
% Add any options not being passed to the report class here
\DeclareOption{pagenumtop}{\newcommand{\pagenumposition}{myheadings}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[letterpaper,12pt]{report}

% Default page number position is bottom
\providecommand{\pagenumposition}{plain}

% Packages required by thesis class
\RequirePackage[utf8]{inputenc}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{setspace}
\RequirePackage[compact]{titlesec}
\usepackage[hang,bf]{caption}
\RequirePackage{fmtcount}
\RequirePackage{tocloft}
\RequirePackage{apalike}
\bibliographystyle{apalike}
\usepackage{multicol}
\usepackage[table]{xcolor}
\usepackage{multirow}
 \usepackage{natbib}
 
% Need to manually add bibliography (done below) for correct ToC placement
%\RequirePackage[nottoc,notbib]{tocbibind}
\RequirePackage{xparse}
\RequirePackage{calc}
\RequirePackage{etoolbox}
% Top and bottom margins are set to have one extra text line of space to account for
% page numbering
\RequirePackage[
  letterpaper,
  tmargin=\baselineskip+1.25in,
  bmargin=\baselineskip+1.25in,
  hmargin=1.25in,
  headsep=0.625in,
  footskip=(\baselineskip/2)+0.625in,
  %showframe
]{geometry}

% The hyperref package allows all internal references to act like hyperlinks
% within the compiled pdf document. It likes to break capitalization in the
% table of contents, so load it last.
\usepackage{hyperref}
\hypersetup{
    pdffitwindow=false,
    pdftitle={\@title},
    pdfauthor={\@author},
    colorlinks=true, % false: boxed links; true: colored links
    linkcolor=black,
    citecolor=black,
    urlcolor=black,
    breaklinks=true,
    hypertexnames=false,
    bookmarksnumbered=true
}
\usepackage[all]{hypcap}

%%%%% Style changes %%%%%
% Make all pages use the same page style
\patchcmd{\chapter}{\thispagestyle{plain}}{}{}{}
\pagestyle{\pagenumposition}
\tocloftpagestyle{\pagenumposition}

% Chapter titles
% Remove space added before chapter titles
\titleformat{\chapter}[display]
  {\normalfont\bfseries\filcenter}
  {\MakeUppercase{\chaptertitlename} \NUMBERstring{chapter}}
  {0em}
  {\MakeUppercase}
\titleformat{name=\chapter,numberless}[display]
  {\normalfont\bfseries\filcenter}
  {}
  {0em}
  {\MakeUppercase}
\titlespacing{\chapter}{0pt}{-1.0 \baselineskip}{0.5 \baselineskip}
\titlespacing{name=\chapter,numberless}{0pt}{-2.0 \baselineskip}{0.5 \baselineskip}

% Section titles
\titleformat{\section}[hang]
  {\normalfont\bfseries}
  {\thesection\hspace{0.8em}}
  {0em}
  {}
\titlespacing{\section}{0pt}{0.5 \baselineskip}{0.25 \baselineskip}

% Subsection titles
\titleformat{\subsection}[hang]
  {\normalfont\slshape}
  {\thesubsection\hspace{0.8em}}
  {0em}
  {}
\titlespacing{\subsection}{0pt}{0.5 \baselineskip}{0.25 \baselineskip}

% Subsubsection titles
\titleformat{\subsubsection}[display]
  {\normalfont\slshape}
  {}
  {0em}
  {}
\titlespacing{\subsubsection}{0pt}{0.5 \baselineskip}{0.25 \baselineskip}

%%%%% Command and environment definitions for each section %%%%%

% Front matter information definitions
\DeclareDocumentCommand \thesistype{m} {\gdef\@thesistype{#1}}
\DeclareDocumentCommand \degree{m} {\gdef\@degree{#1}}
\DeclareDocumentCommand \department {m} {\gdef\@department{#1}}
\DeclareDocumentCommand \submitmonth{m} {\gdef\@submitmonth{#1}}
\DeclareDocumentCommand \submityear{m} {\gdef\@submityear{#1}}

% Centered title, must be inverted pyramid shape
\DeclareDocumentCommand \createtitle{} {%
  \begin{center}
    \begin{spacing}{2.0}
    \MakeUppercase{\@title}
    \end{spacing}
  \end{center}
}

% Copyright information for title and first blank page
\DeclareDocumentCommand \copyrightinfo{} {%
  \begin{singlespace}
    \textcopyright Copyright by \MakeUppercase{\@author}, \@submityear\\
    All Rights Reserved
  \end{singlespace}
}

% Title Page
\RenewDocumentCommand \maketitle{s} {%
  \thispagestyle{empty}%
  \createtitle
  \vspace*{\fill}
  \begin{center}
    By\\
    \vspace{\baselineskip}
    \MakeUppercase{\@author}\\
  \end{center}
  \vspace*{\fill}
  \begin{center}
    A \MakeLowercase{\@thesistype} submitted in partial fulfillment of \\
    the requirements for the degree of \\
    \vspace{\baselineskip}
    \MakeUppercase{\@degree} \\
    \vspace{3.0 \baselineskip}
    \MakeUppercase{Washington State University} \\
   \@department \\
    \vspace{\baselineskip}
    \MakeUppercase{\@submitmonth} \@submityear
    \IfBooleanTF #1 {}{\vspace{\baselineskip}\copyrightinfo}
  \end{center}
  \newpage
  \thispagestyle{empty}%
  \vspace*{\fill}
  \IfBooleanTF #1 {}{\begin{center}\copyrightinfo\end{center}}
  \newpage
}

% Signature Page
\DeclareDocumentEnvironment{signaturepage} {}
{% Signature start
  %\newgeometry{top=1in,bottom=1in,left=1.5in,right=1.5in}%
  \pagenumbering{roman}%
  \setcounter{page}{2}%
  \vspace*{\fill}
  \begin{spacing}{2.0}
    \noindent To the Faculty of Washington State University:
    \par\noindent\hspace{1cm} The members of the Committee appointed to examine the \MakeLowercase{\@thesistype}
of \MakeUppercase{\@author} find it satisfactory and recommend that it be accepted.
  \end{spacing}
  % Add required signatures in main document
}
{% Signature end
  \vspace*{\fill}
  %\restoregeometry
  \newpage
}

% Signature line with name
\DeclareDocumentCommand \signature{m m o O{2}} {%
  \begin{flushright}
    \begin{singlespace}
      \vspace{#4 \baselineskip}
      \rule{0.5\textwidth}{0.4pt} \\
      #1, #2\IfNoValueTF{#3}{}{, #3}
    \end{singlespace}
  \end{flushright}
}

% Acknowledgements page
\DeclareDocumentEnvironment{acknowledgements} {O{Acknowledgements}}
{% Acknowledgements start
  % Add acknowledgements to ToC, phantomsection needed for hyperref
  \addtocontents{toc}{\protect\cftsetindents{chapter}{0em}{0em}}
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}
  \chapter*{#1}
  \begin{spacing}{2.0}
}
{% Acknowledgements end
  \end{spacing}
  \newpage
}

% Abstract page
\RenewDocumentEnvironment{abstract} {m m}%
{% Abstract start
  % Add abstract to ToC, phantomsection needed for hyperref
  \addtocontents{toc}{\protect\cftsetindents{chapter}{0em}{0em}}
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \createtitle
  \begin{center}
    Abstract \\
    \vspace*{3.0 \baselineskip}
    by \@author, #1 \\
    Washington State University \\
    \@submitmonth\ \@submityear \\
    \vspace*{2.0 \baselineskip}
    Chair: #2
    \vspace*{\baselineskip}
  \end{center}
  \begin{spacing}{2.0}
}
{% Abstract end
  \end{spacing}
  \newpage
}

% Table of Contents, List of Figures/Tables
% Place ToC, LoF and LoT on new page
\g@addto@macro{\@cfttocfinish}{\newpage}

% Capitalize chapters in ToC
\let\oldcontentsline\contentsline
\def\contentsline#1#2{%
  \expandafter\ifx\csname l@#1\endcsname\l@chapter
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
  {%
    \oldcontentsline{#1}{\texorpdfstring{\MakeUppercase{#2}}{}}%
  }{%
    \oldcontentsline{#1}{#2}%
  }%
}

% Remove space added in LoF and LoT for each chapter
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}

% Table of Contents
\RenewDocumentCommand \contentsname{} {\MakeUppercase{Table of Contents}}
\RenewDocumentCommand \cfttoctitlefont{} {\hfill\normalsize\bfseries}
\RenewDocumentCommand \cftaftertoctitle{} {\hfill\vspace{\baselineskip}\null\\\null\hfill{Page}}
\RenewDocumentCommand \cftchapfont{} {\normalfont}
\RenewDocumentCommand \cftchappagefont{} {\normalfont}
\RenewDocumentCommand \cftchapaftersnum{} {.}
\RenewDocumentCommand \cftchapleader{} {\cftdotfill{\cftdotsep}}
\setlength{\cftbeforetoctitleskip}{-0.8 \baselineskip}
\setlength{\cftaftertoctitleskip}{0pt}
\setlength{\cftbeforechapskip}{\baselineskip}
\setlength{\cftbeforesecskip}{\baselineskip}
\setlength{\cftbeforesubsecskip}{\baselineskip}
% Remove section and subsection numbering
\RenewDocumentCommand \cftsecpresnum{} {\begin{lrbox}{\@tempboxa}}
\RenewDocumentCommand \cftsecaftersnum{} {\end{lrbox}}
\RenewDocumentCommand \cftsubsecpresnum{} {\begin{lrbox}{\@tempboxa}}
\RenewDocumentCommand \cftsubsecaftersnum{} {\end{lrbox}}

% List of Figures
\AtBeginDocument{\preto{\listoffigures}{
  \addtocontents{toc}{\protect\cftsetindents{chapter}{0em}{0em}}
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
}}
\RenewDocumentCommand \listfigurename{} {\MakeUppercase{List of Figures}}
\RenewDocumentCommand \cftloftitlefont{} {\hfill\normalsize\bfseries}
\RenewDocumentCommand \cftafterloftitle{} {\hfill\vspace{\baselineskip}\null\\\null\hfill{Page}}
\setlength{\cftbeforeloftitleskip}{-0.8 \baselineskip}
\setlength{\cftafterloftitleskip}{0pt}
\setlength{\cftbeforefigskip}{\baselineskip}
%\setlength{\cftbeforesubfigskip}{\baselineskip}

% List of Tables
\AtBeginDocument{\preto{\listoftables}{
  \addtocontents{toc}{\protect\cftsetindents{chapter}{0em}{0em}}
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}
}}
\RenewDocumentCommand \listtablename{} {\MakeUppercase{List of Tables}}
\RenewDocumentCommand \cftlottitlefont{} {\hfill\normalsize\bfseries}
\RenewDocumentCommand \cftafterlottitle{} {\hfill\vspace{\baselineskip}\null\\\null\hfill{Page}}
\setlength{\cftbeforelottitleskip}{-0.8 \baselineskip}
\setlength{\cftafterlottitleskip}{0pt}
\setlength{\cftbeforetabskip}{\baselineskip}
%\setlength{\cftbeforesubtabskip}{\baselineskip}

% Dedication
\DeclareDocumentEnvironment{dedication} {O{Dedication}}
{% Begin dedication
  \topskip0pt
  \vspace*{\fill}
  \centering
  \normalfont\bfseries#1 \\
  \vspace{2.0 \baselineskip}\normalfont
  \begin{spacing}{2.0}
}
{% End dedication
  \end{spacing}
  \strut
  \vfill
  \newpage
}

% Main chapters setup
\DeclareDocumentEnvironment{mainchapters} {}
{% Main chapters start
  % Add chapter label to ToC and format entries
  % Formatting carries on to the rest of the ToC
  \addtocontents{toc}{\vspace*{\baselineskip}\texorpdfstring{\MakeUppercase{\chaptertitlename}}{}\par}
  \addtocontents{toc}{%
    \protect\cftsetindents{chapter}{1.5em}{1.5em}
    \protect\cftsetindents{section}{3.0em}{0em}
    \protect\cftsetindents{subsection}{4.5em}{0em}
  }
  \pagenumbering{arabic}
  \begin{spacing}{2.0}
}
{% End main chapters
  \end{spacing}
}

% Appendices setup
% Add appendix label to ToC
\let\oldappendix\appendix
\renewcommand*{\appendix}{
  \oldappendix
  % Add appendix label to ToC, adjust title options for appendices to add letters instead of numbers
  \addtocontents{toc}{\vspace*{\baselineskip}\texorpdfstring{\MakeUppercase{\chaptertitlename}}{}\par}
   \addtocontents{toc}{%
    \protect\cftsetindents{chapter}{1.5em}{1.5em}
    \protect\cftsetindents{section}{3.0em}{0em}
    \protect\cftsetindents{subsection}{4.5em}{0em}
  }  \titleformat{\chapter}[display]
    {\normalfont\bfseries\filcenter}
    {\MakeUppercase{\chaptertitlename} \Alph{chapter}}
    {0em}
    {\MakeUppercase}
}
\DeclareDocumentEnvironment{appendices} {}
{% Appendices start
  \appendix
  \begin{spacing}{2.0}
}
{% End appendices
  \end{spacing}
}

% References
\DeclareDocumentCommand \makebibliography{m O{Bibliography}} {
  \newpage
  % Add bibliography to ToC, phantomsection needed for hyperref
  \addtocontents{toc}{\protect\cftsetindents{chapter}{0em}{0em}}
  \phantomsection
  \addcontentsline{toc}{chapter}{#2}
  \begin{spacing}{1.0}
    \bibliographystyle{abbrvnat}
    \bibliography{#1}
  \end{spacing}
}
\setcitestyle{authoryear,open={(},close={)}}