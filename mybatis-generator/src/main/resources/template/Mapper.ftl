package ${packageMapper}.base;

import java.util.List;
import ${packageModel}.${className};

/**
*${mapperName}BaseMapper
*  @author ${author}
*/
public interface ${mapperName}BaseMapper {

    <#include "base/insertMapper.ftl">

    <#include "base/updateMapper.ftl">

    <#include "base/selectMapper.ftl">

}