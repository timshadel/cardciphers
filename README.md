# Card Ciphers
_A collection of Ruby implementations of ciphers meant for playing cards._

Card ciphers are fun because they typically have a large enough key space that purely brute force methods
won't work, and their pseudo-random keystreams are close enough to random that basic methods like the frequency
analysis you use in newspaper cryptograms won't work either.

![A diagram of the process used by card ciphers to turn regular text into encrypted alphabetic strings.][packing]

[packing]: ./cardcipher-packaging.png "Overview of card cipher encryption and decryption process"

## Definitions

The rigor of the terminology used in describing card ciphers varies, and so I want to establish some definitions
that will be used throughout the code.

_**internal operation**_<br/>
An action which alters the state of the deck, and is carried out completely by information contained
within the deck itself or the published algorithm.

_**external operation**_<br/>
An operation that relies on some kind of external information to be completed correctly. That
information is usually a secret passphrase used to key the deck, or an initialization vector used to scramble
the keystream of an already keyed deck.

_**key**_<br/>
This is the original ordering of the cards, before any operations have been performed. You may have
arrived at this ordering through applying external operations to a well known starting order using a secret
passphrase. This is the ordering that must be kept safe from the secret police.

_**iv**_<br/>
The initialization vector is a value whose letters are used to perform external operations that
cannot be determined by the cards of the deck. Their purpose is identical to that of an IV in any other cipher:
they significantly alter the keystream so that a single key may be used for more than message. They aren't secrets.
They must be used only once, or the security of every message encrypted with that key is lost.

## Operations

Each algorithms requires a description of how to manipulate the deck. Standardizing those instructions requires
describing each operation so that they may be performed correctly given any algorithm we are coding.

_**deck orientation**_<br/>
By convention, unless otherwise specified the deck is held face up, with _top_
referring to the card you can see at the top of the deck, and _bottom_ referring to the card closest to your
hand at the bottom of the deck.

_**advance** (specific card)_<br/>
Locate that card within the deck, then move it one position closer to the bottom of the deck. (_what
happens when at the bottom of the deck?_)

_**discard** (optional pile #)_<br/>
Take the top card of the deck and place it face up in a discard pile. If more than one pile is used,
then a discard pile number must be specified.
