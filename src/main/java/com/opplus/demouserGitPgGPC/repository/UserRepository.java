package com.opplus.demouserGitPgGPC.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.opplus.demouserGitPgGPC.domain.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long>{

}
