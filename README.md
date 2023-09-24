<!-- Copyright (C) 2023 by Jinwen XU -->

# `homework`, a LaTeX class for writing your homework

## Introduction

The current document class is for writing homework. It has the following features.
- Simple and clear interface.
- Built-in support for many theorem-like environments, already configured and ready to use (in the mean time also very customizable, via `\SetTheorem`).
- Multilingual support: currently supporting Chinese (both simplified and traditional), English, French, German, Italian, Japanese, Portuguese (European and Brazilian), Russian and Spanish.
- Page numbers are of the form `Page [current] of [total]`, which can help you ensure there are no missing pages when you print your homework for submission.
- Support writing problem statements and solutions or proofs in different colors.
- Every statement / solution has its own QED symbol, in hollow or solid shape.
- You may mark unfinished parts with `\DNF` or `\DNF<⟨remark⟩>` (meaning "did not finish") for reminding — this will give you a report on unfinished parts at the end of your document.


## Usage

A typical document looks like this:

```latex
\documentclass[11pt,
  logo = {image-file-name},
  % logo height = 2\baselineskip,
  title in boldface,
  title in sffamily,
  theorem in new line,
]{homework}

\UseLanguage{...} % If you wish to write your document in languages other than English


\title{The Subject, Week 1}
\author{Author NAME}
\date{\TheDate{2023-12-25}, Location} % or: \date{\today[only-year-month], Location}


\begin{document}


% If you wish to write the answer directly...

\begin{problem}
    Here lies the solution / proof.
\end{problem}


% If you wish to state the problem and then write your answer...

\begin{problem}
    You may also state the problem here...
\end{problem}

\begin{solution}
    ... and write the solution here...
\end{solution}

% If you prefer "Proof" instead of "Solution"...

\begin{solution}[Proof]
    ... or a proof like this one...
    % You may write lemmas or propositions inside your solution
    \begin{lemma}\label{lem}
        Some auxiliary result.
    \end{lemma}
    \begin{proof}
        The proof of \cref{lem}.
    \end{proof}
    ... and the rest steps...
\end{solution}


\end{document}
```

> You may refer to the demo documents for more examples.

A few remarks:
1) The logo image can be included via the class option `logo = {⟨image file name⟩}`, and if you are not satisfied with its default size, then you may manually specify the size via the option `logo height = {⟨height⟩}`. If you do not want to show any logo in the title bar, you may simply remove the option `logo = {⟨image file name⟩}`.
1) The options `title in boldface`, `title in sffamily` or even `title in scshape` are for configuring the font effect of the title line, the sectional titles and theorem names.
1) The option `theorem in new line` is for showing the problem / theorem name, numbering and description in a separate line, for the sake of clarity.
1) `\title`, `author` and `\date` should be placed before `\begin{document}`.
1) Since the problem, solution and other theorem-type environments have a QED symbol at the end, if your text ends with displayed formula or lists, then you may need to place a `\qedhere` so that the QED symbol is placed in the right place.


## TeXnical details

### Engines and base classes
- With pdfLaTeX, the base class is `minimart`.
- With XeLaTeX or LuaLaTeX, the base class is `einfart`.

### Regarding `\maketitle`

The `\maketitle` has been automatically added just after `\begin{document}`, thus you don't need to write it by yourself. Note, however, that this also means that you cannot place `\title`, `author` and `\date` after `\begin{document}`.


# License

This work is released under the LaTeX Project Public License, v1.3c or later.
