// Copyright (c) 2020-2024 The GigAddik Coin developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
 
#include <util.h>

/**
 * Determine the masternode collateral value based on block height
 */
CAmount CollateralRequired(int nHeight);

/**
 * Provide transition period for masternode collateral change to avoid
 * unneccessary issues to masternode operators, returns true if given
 * amount is accepted as valid collateral.
 */
bool IsValidCollateral(CAmount nAmountToCheck, int nHeight);