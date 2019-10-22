package ${packageModel};

import java.util.*;
import lombok.*;
import javax.persistence.Column;
import java.time.*;

/**
*  ${className}
*  @author ${author}
*/
@Setter
@Getter
@ToString
@Builder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class ${className} {

    /**
    * FETCH_FIELDS
    */
    private static final String FETCH_FIELDS="fetchFields";
<#list attrs as attr>

    <#if attr.remarks!="" || attr.nullAble?? ||attr.columnDef??>
    /**
     *${attr.remarks}
     */
    </#if>
    @Column(name = "${tableName}.${attr.columnName}")
    private ${attr.javaTypeName} ${attr.propertiesName};
</#list>
    @Builder.Default
    private Map<String,Object> fetchFields = new HashMap<>();
<#list attrs as attr>
    private List<${attr.javaTypeName}> ${attr.propertiesName}List;
</#list>
<#list attrs as attr>

    /** 获取某个字段
     * @return ${attr.propertiesName?cap_first}
     */
    public ${className} fetch${attr.propertiesName?cap_first}(){
        return setFetchFields("${attr.propertiesName}");
    }
</#list>

    /** 获取全部字段
     * @return AllFields
     */
    public ${className} fetchAll(){
        this.fetchFields.put("AllFields",true);
        return this;
    }

    @SuppressWarnings("unchecked")
    private ${className} setFetchFields(String val){
        Map<String,Boolean> fields= (Map<String, Boolean>) this.fetchFields.get(FETCH_FIELDS);
        if (fields == null){ fields = new HashMap<>(); }
        fields.put(val,true);
        this.fetchFields.put(FETCH_FIELDS,fields);
        return this;
    }
}