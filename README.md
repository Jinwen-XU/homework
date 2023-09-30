<!-- Copyright (C) 2023 by Jinwen XU -->

# `homework`, a LaTeX class for writing your homework

## Introduction

The current document class is for writing homework. It has the following features.
- Simple and clear interface.
- Built-in support for many theorem-type environments, already configured and ready to use (in the mean time also very customizable, via `\SetTheorem`), with clever referencing supported.
- Multilingual support: currently supporting Chinese (both simplified and traditional), English, French, German, Italian, Japanese, Portuguese (European and Brazilian), Russian and Spanish.
- Page numbers are of the form `Page [current] of [total]`, which can help you ensure that there are no missing pages when you print your homework for submission.
- Support writing problem statements and solutions (or proofs) in different colors.
- Every statement and solution has its own Q.E.D. symbol, in hollow or solid shape, respectively.
- You may mark unfinished parts with `\DNF` or `\DNF<⟨remark⟩>` (meaning "did not finish") for reminding — this will give you a clickable report on the unfinished parts at the end of your document.

## Installation and preparation

### How to install this package

If you are using TeX Live 2024 or newer, or the most recent version of MikTeX, then this package should already be included, and you don't need to do anything.

Otherwise, you need to check for package update to see if you can receive it. In case not, you can always go to [the CTAN page](https://ctan.org/pkg/homework) to download the `.zip` file with all related files included.

### Regarding the fonts

If you are using a Unicode TeX engine, then the current document class requires the following open-source fonts that are not included in the standard TeX collection:

- The Source Han font series at [Adobe Fonts](https://github.com/adobe-fonts). More specifically:
  - Source Han Serif, [go to its Release page](https://github.com/adobe-fonts/source-han-serif/releases).
  - Source Han Sans, [go to its Release page](https://github.com/adobe-fonts/source-han-sans/releases).
  - Source Han Mono, [go to its Release page](https://github.com/adobe-fonts/source-han-mono/releases).
  > It is recommended to download the Super-OTC version, so that the total download size would be smaller, and the installation would be easier.

These are necessary if you wish to write your document in Chinese (either simplified or traditional) or Japanese. Also, without these fonts installed, the compilation speed might be much slower if you use XeLaTeX or LuaLaTeX to compile your document.


## Usage

A typical homework document looks like this:

```latex
\documentclass[a4paper, 11pt,
  logo = {image-file-of-your-university-logo}, % Remove this line if you don't want logo presented.
  % logo height = 1cm, % In case you are not satisfied with the default logo size.
  title in boldface,
  title in sffamily,
  theorem in new line,
  % twoside,
]{homework}

\UseLanguage{...} % If you wish to write your homework in languages other than English.


\title{The Subject, Week 1}
\author{Author NAME}
\date{\TheDate{2023-12-25}, Location} % or: \date{\today[only-year-month], Location}


\begin{document}


% If you wish to write the answer directly...

\begin{problem}
    Here lies the solution / proof.
\end{problem}


% If you wish to state the problem and then write your answer...

\begin{problem}[You can add some brief problem description here]
    You may also state the problem here...
\end{problem}

\begin{solution}% You may also use the "answer" environment, they are essentially the same.
    ... and write the solution here...
\end{solution}


% If you prefer "Proof" instead of "Solution"...

\begin{solution}[Proof]
    % You may write claims, lemmas, propositions, etc. inside your solution.
    \begin{lemma}\label{lem}
        Some auxiliary result.
    \end{lemma}
    \begin{proof}
        The proof of \cref{lem}, where we use the following formula:
        \[
            \infty = \infty + 1.
            \qedhere % For placing the Q.E.D. symbol in the right place.
        \]
    \end{proof}
    \begin{fact}[This statement requires no proof]
        \proofless % To change the hollow box marking the end of a theorem-type environment into a solid one.
        Some statement.
    \end{fact}
    ... and the rest steps...
\end{solution}


% If you wish to answer each sub-question of a problem separately...

\begin{problem}[A problem with many sub-questions]
    \begin{enumerate}[itemsep=.5\baselineskip]
        \item First question.
        \begin{solution}
            The solution of the first question.
        \end{solution}
        \item Second question.
        \begin{enumerate}[itemsep=.3\baselineskip]
            \item First sub-question.
            \begin{solution}
                The solution of the first sub-question.
            \end{solution}
            \item Second sub-question.
            \begin{solution}
                The solution of the second sub-question.
            \end{solution}
        \end{enumerate}
        \item Third question.
        \begin{solution}
            The solution of the third question.
        \end{solution}
    \end{enumerate}
    \noQED % Use \noqed or \noQED at the end to suppress the Q.E.D. symbol that marks the end of the current problem.
\end{problem}


% If there is a question that you can't figure out how to solve at the moment...

\DNF<some description>


\end{document}
```

> You may refer to the demo documents for more examples.

Regarding some of the class options:
1) The logo image can be included via the class option `logo = {⟨image file name⟩}`, and if you are not satisfied with its default size, then you may manually specify the size via the option `logo height = {⟨height⟩}` or `logo width = {width}`. If you do not want to show any logo in the title bar, you may simply remove the option `logo = {⟨image file name⟩}`.
1) The options `title in boldface`, `title in sffamily` or even `title in scshape` are for configuring the text effect of the title line, the sectional titles and theorem names.
1) The option `theorem in new line` is for showing the problem / theorem name, numbering and description in a separate line, for the sake of clarity.
1) The option `twoside` is for double-sided printing.

A few extra remarks:
1) `\title`, `\author` and `\date` should be placed before `\begin{document}`.
1) Since the problem, solution and other theorem-type environments have a Q.E.D. symbol at the end, if your text ends with a displayed equation or a `itemize`/`enumerate`/`description` list, then you would need to add a `\qedhere` so that the Q.E.D. symbol is placed in the right place. There are also `\proofless` and `\noQED` for controlling the Q.E.D. symbol, see the demo documents for their usage.
1) Every theorem-type environment has a starred unnumbered version, for instance, `claim*` for unnumbered `claim`, `lemma*` for unnumbered `lemma`, etc.
1) It is recommended to use clever reference, such as `\cref`, `\Cref` and `\namecref`, etc. For languages such as French and German, to ensure that the generated referencing text is grammatically correct, you may write the definite article and/or declension as optional argument for the referencing commands, for instance, `\cref[à]{⟨label⟩}` or `\cref[de]{⟨label⟩}` for French, `\cref[nom.]{⟨label⟩}` or `\cref[von,dat.]{⟨label⟩}` for German, etc.


## TeXnical details

### Engines and base classes
- With pdfLaTeX, the base class is `minimart`.
- With XeLaTeX or LuaLaTeX, the base class is `einfart`.

### Some other aspects

#### Regarding `\maketitle`

The `\maketitle` has been automatically added just after `\begin{document}`, thus you don't need to write it by yourself. Note, however, that this also means that you cannot place `\title`, `author` and `\date` after `\begin{document}`.

#### Regarding the numbering

A new counter named `homework` is defined, which is shared by the environments `problem`, `question` and `exercise`, thus you would see them numbered as `1`, `2`, `3`, etc. The other theorem-type environments are numbered within this counter `homework`, thus within, say, `Problem 1`, you would see them numbered as `Theorem 1.1`, `Lemma 1.2` and `Claim 1.3`, etc.

Therefore, if you wish to manually change the numbering, you may directly access the value of the counter `homework`. Also, each theorem-type environment has its own counter, thus it would still work if you write `\setcounter{exercise}{10}`, but this would also affect the numbering of `problem` and `question`, so don't forget to reset the value as needed.

If you wish them to be numbered separately, you may define new counters, say `problem-counter`, `question-counter` and `exercise-counter` via
```latex
\newcounter{problem-counter}
\newcounter{question-counter}
\newcounter{exercise-counter}
```
and then write this in your preamble:
```latex
\SetTheorem{problem}{shared counter=problem-counter}
\SetTheorem{question}{shared counter=question-counter}
\SetTheorem{exercise}{shared counter=exercise-counter}
```


# License

This work is released under the LaTeX Project Public License, v1.3c or later.
