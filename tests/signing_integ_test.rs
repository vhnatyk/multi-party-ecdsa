extern crate cryptography_utils;
extern crate multi_party_ecdsa;

use cryptography_utils::BigInt;
use multi_party_ecdsa::protocols::two_party_ecdsa::lindell_2017::*;

#[test]
fn test_two_party_sign() {
    // assume party1 and party2 engaged with KeyGen in the past resulting in
    // party1 owning private share and paillier key-pair
    // party2 owning private share and paillier encryption of party1 share
    let (_party_one_private_share_gen, _comm_witness, ec_key_pair_party1) =
        party_one::KeyGenFirstMsg::create_commitments();
    let (party_two_private_share_gen, ec_key_pair_party2) = party_two::KeyGenFirstMsg::create();

    let keypair =
        party_one::PaillierKeyPair::generate_keypair_and_encrypted_share(&ec_key_pair_party1);

    // creating the ephemeral private shares:

    let (eph_party_two_first_message, eph_comm_witness, eph_ec_key_pair_party2) =
        party_two::EphKeyGenFirstMsg::create_commitments();
    let (eph_party_one_first_message, eph_ec_key_pair_party1) =
        party_one::EphKeyGenFirstMsg::create();
    let eph_party_two_second_message = party_two::EphKeyGenSecondMsg::verify_and_decommit(
        eph_comm_witness,
        &eph_party_one_first_message.d_log_proof,
    )
    .expect("party1 DLog proof failed");

    let _eph_party_one_second_message =
        party_one::EphKeyGenSecondMsg::verify_commitments_and_dlog_proof(
            &eph_party_two_first_message,
            &eph_party_two_second_message,
        )
        .expect("failed to verify commitments and DLog proof");
    let party2_private = party_two::Party2Private::set_private_key(&ec_key_pair_party2);
    let message = BigInt::from(1234);
    let partial_sig = party_two::PartialSig::compute(
        &keypair.ek,
        &keypair.encrypted_share,
        &party2_private,
        &eph_ec_key_pair_party2,
        &eph_party_one_first_message.public_share,
        &message,
    );

    let party1_private = party_one::Party1Private::set_private_key(&ec_key_pair_party1, &keypair);

    let signature = party_one::Signature::compute(
        &party1_private,
        &partial_sig.c3,
        &eph_ec_key_pair_party1,
        &eph_party_two_second_message.comm_witness.public_share,
    );

    let pubkey = party_one::compute_pubkey(
        &ec_key_pair_party1,
        &party_two_private_share_gen.public_share,
    );
    party_one::verify(&signature, &pubkey, &message).expect("Invalid signature")
}
