package com.opplus.demouserGitPgGPC.mapper;

import org.mapstruct.Mapper;

import com.opplus.demouserGitPgGPC.domain.UserEntity;
import com.opplus.demouserGitPgGPC.dto.UserDto;


@Mapper(componentModel = "spring", uses = {})
public interface UserMapper extends EntityMapper<UserDto, UserEntity>{


}